import 'dart:convert';
import 'package:apppointment/api/appointment_calendar.dart';
import 'package:apppointment/api/appointment_update_api.dart';
import 'package:apppointment/api/convrnirnt_day_api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Message_Confirm_Edit extends StatefulWidget {
  final int appointmentId;
  final int user_id;
  final int role_user;
  final int target_id;
  final DateTime date;
  final String title;
  final String titleDetail;
  final String timeStart;
  final String timeEnd;
  final String location;

  const Message_Confirm_Edit(
      this.appointmentId,
      this.user_id,
      this.role_user,
      this.target_id,
      this.date,
      this.title,
      this.titleDetail,
      this.timeStart,
      this.timeEnd,
      this.location,
      {Key? key})
      : super(key: key);

  @override
  State<Message_Confirm_Edit> createState() => _Message_Confirm_EditState();
}

class _Message_Confirm_EditState extends State<Message_Confirm_Edit> {
  late Future<List<AppointmentCalendarModel>> futureAppointmentCalendar;
  late Future<List<ConvenientDayModel>>? futureConvenientDay;
  final _updateAppointment = GlobalKey<FormState>();
  final roomController = TextEditingController();
  final notApprovedController = TextEditingController();

  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String? appointmentTimeStart;
  String? appointmentTimeEnd;

  List<AppointmentCalendarModel> matchingAppointments = [];
  List<ConvenientDayModel> convenientDays = [];

  @override
  void initState() {
    super.initState();
    roomController.text = widget.location;
    selectedStartTime = _parseTime(widget.timeStart);
    selectedEndTime = _parseTime(widget.timeEnd);

    initializeDateFormatting('th_TH', null).then((_) {
      setState(() {
        futureAppointmentCalendar = fetchAppointmentCalendar(widget.user_id);
        futureConvenientDay = fetchConvenientDay(
            widget.role_user == 0 ? widget.target_id : widget.user_id);
      });
    });

    // Provide a default value to avoid LateInitializationError
    futureAppointmentCalendar = Future.value([]);
    futureConvenientDay = Future.value([]); // Initialize with an empty list
  }

  TimeOfDay? _parseTime(String time) {
    try {
      final format = DateFormat('HH:mm:ss');
      final dateTime = format.parse(time);
      return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    } catch (e) {
      print("Error parsing time: $e");
      return null;
    }
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  bool _validateTimeRange() {
    if (selectedStartTime != null && selectedEndTime != null) {
      final startTimeInMinutes =
          selectedStartTime!.hour * 60 + selectedStartTime!.minute;
      final endTimeInMinutes =
          selectedEndTime!.hour * 60 + selectedEndTime!.minute;
      return endTimeInMinutes > startTimeInMinutes;
    }
    return false;
  }

  bool _isTimeSlotOverlapping() {
    if (selectedStartTime != null && selectedEndTime != null) {
      final newStartMinutes =
          selectedStartTime!.hour * 60 + selectedStartTime!.minute;
      final newEndMinutes =
          selectedEndTime!.hour * 60 + selectedEndTime!.minute;

      for (var appointment in matchingAppointments) {
        // Skip the current appointment
        if (appointment.id == widget.appointmentId) continue;

        final appointmentStartTime = _parseTime(appointment.timeStart);
        final appointmentEndTime = _parseTime(appointment.timeEnd);

        if (appointmentStartTime != null && appointmentEndTime != null) {
          final appointmentStartMinutes =
              appointmentStartTime.hour * 60 + appointmentStartTime.minute;
          final appointmentEndMinutes =
              appointmentEndTime.hour * 60 + appointmentEndTime.minute;

          // Check for overlap
          if ((newStartMinutes < appointmentEndMinutes &&
                  newEndMinutes > appointmentStartMinutes) ||
              (newStartMinutes == appointmentStartMinutes &&
                  newEndMinutes == appointmentEndMinutes)) {
            return true; // Overlap found
          }
        }
      }
    }
    return false;
  }

  bool _isTimeWithinAvailableRange(TimeOfDay startTime, TimeOfDay endTime) {
    if (convenientDays.isEmpty) return false;

    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    print("Selected Start Minutes: $startMinutes, End Minutes: $endMinutes");

    for (var day in convenientDays) {
      print("Checking availability for day: ${day}");
      final availableStart = _parseTime(day.timeStart);
      final availableEnd = _parseTime(day.timeEnd);

      if (availableStart != null && availableEnd != null) {
        final availableStartMinutes =
            availableStart.hour * 60 + availableStart.minute;
        final availableEndMinutes =
            availableEnd.hour * 60 + availableEnd.minute;

        print(
            "Available Start Minutes: $availableStartMinutes, End Minutes: $availableEndMinutes");

        if (startMinutes >= availableStartMinutes &&
            endMinutes <= availableEndMinutes) {
          print("Time is within the available range.");
          return true; // Time is within the available range
        }
      }
    }
    print("Time is outside the available range.");
    return false; // Time is outside the available range
  }

  Future<AppointmentUpdateModel> updateAppointment() async {
    final appointmentId = widget.appointmentId;
    final location = roomController.text;
    final notApproved = notApprovedController.text;
    final timeStart = _formatTimeOfDay(selectedStartTime!);
    final timeEnd = _formatTimeOfDay(selectedEndTime!);

    final url =
        Uri.parse('https://appt-cis.smt-online.com/api/appointment/update_2');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + globals.jwtToken
    };

    final body = jsonEncode({
      'id': appointmentId,
      'location': location,
      'notApprovedDetail': notApproved,
      'appointments': [
        {
          'time_start': timeStart,
          'time_end': timeEnd,
        }
      ],
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final appointmentUpdateModel =
          AppointmentUpdateModel.fromJson(json.decode(response.body));
      return appointmentUpdateModel;
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: "แก้ไขนัดหมายไม่สำเร็จ",
        desc: "กรอกข้อมูลนัดหมายไม่ครบ",
        btnOkOnPress: () {},
      ).show();
      throw Exception('Failed to update appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black, // สีของเงา
        title: const Text('แก้ไขข้อมูลการนัดหมาย'),
      ),
      body: SingleChildScrollView(
        child: widget.role_user == 0
            ? _buildWidgetForStudent()
            : _buildWidgetForTeacher(),
      ),
    );
  }

  @override
  Widget _buildWidgetForStudent() {
    return Form(
      key: _updateAppointment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: FutureBuilder<List<AppointmentCalendarModel>>(
          future: futureAppointmentCalendar,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('ไม่มีข้อมูล'));
            } else {
              List<AppointmentCalendarModel> appointmentCalendar =
                  snapshot.data!;
              List<DateTime> dates = appointmentCalendar
                  .map((appointment) => appointment.date)
                  .toList();

              DateTime selectedDate = widget.date;

              final Map<String, int> dayOfWeekMap = {
                'Monday': 1,
                'Tuesday': 2,
                'Wednesday': 3,
                'Thursday': 4,
                'Friday': 5,
              };

              // Only print date and day of the week once, not in FutureBuilder
              String dayOfWeekEnglish = DateFormat('EEEE').format(selectedDate);
              // Convert day of the week to the corresponding number
              int dayOfWeekNumber = dayOfWeekMap[dayOfWeekEnglish] ?? 0;

              print(
                  "Selected date: $selectedDate ($dayOfWeekEnglish - $dayOfWeekNumber)");

              matchingAppointments.clear(); // Clear previous list

              for (var appointment in appointmentCalendar) {
                if (appointment.date.year == selectedDate.year &&
                    appointment.date.month == selectedDate.month &&
                    appointment.date.day == selectedDate.day) {
                  matchingAppointments.add(appointment);
                }
              }

              return FutureBuilder<List<ConvenientDayModel>>(
                  future: futureConvenientDay,
                  builder: (context, convenientSnapshot) {
                    if (convenientSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (convenientSnapshot.hasError) {
                      return Center(
                        child:
                            Text('เกิดข้อผิดพลาด: ${convenientSnapshot.error}'),
                      );
                    } else if (!convenientSnapshot.hasData ||
                        convenientSnapshot.data!.isEmpty) {
                      return Center(child: Text('ไม่มีข้อมูล'));
                    } else {
                      List<ConvenientDayModel> convenientDay =
                          convenientSnapshot.data!;

                      // แสดงข้อมูล convenientDay ทั้งหมดที่ได้มา
                      print("ConvenientDayModel data: $convenientDay");

                      ConvenientDayModel? matchingConvenientDay = convenientDay
                          .firstWhere((day) => day.day == dayOfWeekNumber);

                      List<String> convenientTimes = [];

                      if (matchingConvenientDay != null) {
                        // Assume convenientTimes is a list of strings in "HH:mm" format
                        convenientTimes = [
                          matchingConvenientDay.timeStart,
                          matchingConvenientDay.timeEnd
                        ];

                        convenientDays.clear(); // Clear previous list

                        if (convenientTimes.length == 2) {
                          // Create a ConvenientDayModel object with the given date and times
                          ConvenientDayModel convenientDay = ConvenientDayModel(
                            id: widget.user_id, // Provide a valid id
                            userId: widget.target_id, // Provide a valid userId
                            day:
                                dayOfWeekNumber, // Provide the day of the week number
                            timeStart: convenientTimes[0],
                            timeEnd: convenientTimes[1],
                            createdAt: DateTime.now().toIso8601String(),
                            updatedAt: DateTime.now().toIso8601String(),
                            deletedAt: null, // Use null if not applicable
                          );

                          convenientDays.add(convenientDay);
                        }
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                'ช่วงเวลาว่างของอาจารย์: ',
                                style: TextStyle(fontSize: 18),
                              ),
                              // แสดงเวลาที่ดึงมาใน Text widget
                              Text(
                                convenientTimes.isNotEmpty
                                    ? '${convenientTimes[0]} - ${convenientTimes[1]}'
                                    : 'ไม่มีช่วงเวลาว่าง',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (matchingAppointments.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: matchingAppointments.map((appointment) {
                                String startTime = appointment.timeStart;
                                String endTime = appointment.timeEnd;
                                bool isCurrentAppointment =
                                    appointment.id == widget.appointmentId;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isCurrentAppointment
                                          ? 'นัดหมายนี้:'
                                          : 'นัดหมายอื่น:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: isCurrentAppointment
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'เริ่ม: $startTime - สิ้นสุด: $endTime',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 10),
                                    Divider(),
                                    SizedBox(height: 10),
                                  ],
                                );
                              }).toList(),
                            ),
                          Row(
                            children: [
                              Text('ช่วงเวลา', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime:
                                          selectedStartTime ?? TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      setState(() {
                                        selectedStartTime = pickedTime;
                                      });
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'เวลาเริ่ม',
                                    ),
                                    child: Text(
                                      selectedStartTime?.format(context) ??
                                          'เลือกเวลาเริ่ม',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'ถึง',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime:
                                          selectedEndTime ?? TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      setState(() {
                                        selectedEndTime = pickedTime;
                                      });
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'เวลาจบ',
                                    ),
                                    child: Text(
                                      selectedEndTime?.format(context) ??
                                          'เลือกเวลาจบ',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Divider(),
                          const SizedBox(height: 10),
                          Text(
                            'สถานที่',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.5)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1.0,
                                  blurRadius: 3.0,
                                  offset: const Offset(0.0, 1.0),
                                ),
                              ],
                            ),
                            child: Theme(
                              data: ThemeData(
                                inputDecorationTheme: InputDecorationTheme(
                                  border: InputBorder.none,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: TextFormField(
                                  controller: roomController,
                                  decoration: InputDecoration(
                                    hintText: 'กรอกห้องที่สะดวก',
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily:
                                          GoogleFonts.prompt().fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Divider(),
                          const SizedBox(height: 10),
                          Text(
                            'เหตุผลที่แก้ไข',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.5)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1.0,
                                  blurRadius: 3.0,
                                  offset: const Offset(0.0, 1.0),
                                ),
                              ],
                            ),
                            child: Theme(
                              data: ThemeData(
                                inputDecorationTheme: InputDecorationTheme(
                                  border: InputBorder.none,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกเหตุผลที่แก้ไข';
                                    }
                                    return null;
                                  },
                                  controller: notApprovedController,
                                  decoration: InputDecoration(
                                    hintText: 'กรอกเหตุผลที่แก้ไข',
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily:
                                          GoogleFonts.prompt().fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Divider(),
                          const SizedBox(height: 10),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 116, 211),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  if (_updateAppointment.currentState!
                                      .validate()) {
                                    if (!_validateTimeRange()) {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                        title: "เวลาไม่ถูกต้อง",
                                        desc:
                                            "กรุณาเลือกเวลาเริ่มต้นก่อนเวลาเลิก.",
                                        btnOkOnPress: () {},
                                      ).show();
                                      return;
                                    }

                                    if (_isTimeSlotOverlapping()) {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                        title: "เวลาไม่ถูกต้อง",
                                        desc: "เวลาเลือกทับซ้อนกับนัดหมายอื่น.",
                                        btnOkOnPress: () {},
                                      ).show();
                                      return;
                                    }

                                    if (!_isTimeWithinAvailableRange(
                                        selectedStartTime!, selectedEndTime!)) {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                        title: "เวลาไม่ถูกต้อง",
                                        desc:
                                            "เวลาเลือกอยู่นอกช่วงเวลาที่ว่างของอาจารย์.",
                                        btnOkOnPress: () {},
                                      ).show();
                                      return;
                                    }

                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      animType: AnimType.topSlide,
                                      showCloseIcon: true,
                                      title: "ยืนยันการแก้ไข?",
                                      desc: "คุณต้องการแก้ไขนัดหมายใช่หรือไม่?",
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        try {
                                          AppointmentUpdateModel res =
                                              await updateAppointment();
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.topSlide,
                                            showCloseIcon: true,
                                            title: "แก้ไขนัดหมายสำเร็จ",
                                            btnOkOnPress: () {},
                                          ).show();
                                        } catch (e) {
                                          print(
                                              'Error updating appointment: $e');
                                        }
                                      },
                                    ).show();
                                  }
                                },
                                child: const Center(
                                  child: Text(
                                    "แก้ไขข้อมูลนัดหมาย",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }
                  });
            }
          },
        ),
      ),
    );
  }

  Widget _buildWidgetForTeacher() {
    return Form(
      key: _updateAppointment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: FutureBuilder<List<AppointmentCalendarModel>>(
          future: futureAppointmentCalendar,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('ไม่มีข้อมูล'));
            } else {
              List<AppointmentCalendarModel> appointmentCalendar =
                  snapshot.data!;
              List<DateTime> dates = appointmentCalendar
                  .map((appointment) => appointment.date)
                  .toList();

              print(dates);

              DateTime selectedDate = widget.date;

              final Map<String, int> dayOfWeekMap = {
                'Monday': 1,
                'Tuesday': 2,
                'Wednesday': 3,
                'Thursday': 4,
                'Friday': 5,
              };

              // Only print date and day of the week once, not in FutureBuilder
              String dayOfWeekEnglish = DateFormat('EEEE').format(selectedDate);
              // Convert day of the week to the corresponding number
              int dayOfWeekNumber = dayOfWeekMap[dayOfWeekEnglish] ?? 0;

              print(
                  "Selected date: $selectedDate ($dayOfWeekEnglish - $dayOfWeekNumber)");

              matchingAppointments.clear(); // Clear previous list

              for (var appointment in appointmentCalendar) {
                if (appointment.date.year == selectedDate.year &&
                    appointment.date.month == selectedDate.month &&
                    appointment.date.day == selectedDate.day) {
                  matchingAppointments.add(appointment);
                }
              }
              return FutureBuilder<List<ConvenientDayModel>>(
                  future: futureConvenientDay,
                  builder: (context, convenientSnapshot) {
                    if (convenientSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (convenientSnapshot.hasError) {
                      return Center(
                        child:
                            Text('เกิดข้อผิดพลาด: ${convenientSnapshot.error}'),
                      );
                    } else if (!convenientSnapshot.hasData ||
                        convenientSnapshot.data!.isEmpty) {
                      return Center(child: Text('ไม่มีข้อมูล'));
                    } else {
                      List<ConvenientDayModel> convenientDay =
                          convenientSnapshot.data!;

                      // แสดงข้อมูล convenientDay ทั้งหมดที่ได้มา
                      print("ConvenientDayModel data: $convenientDay");

                      ConvenientDayModel? matchingConvenientDay = convenientDay
                          .firstWhere((day) => day.day == dayOfWeekNumber);

                      List<String> convenientTimes = [];

                      if (matchingConvenientDay != null) {
                        print("Matching day: $matchingConvenientDay");
                        print("Time start: ${matchingConvenientDay.timeStart}");
                        print("Time end: ${matchingConvenientDay.timeEnd}");

                        // Assume convenientTimes is a list of strings in "HH:mm" format
                        convenientTimes = [
                          matchingConvenientDay.timeStart,
                          matchingConvenientDay.timeEnd
                        ];

                        print(
                            "Convenient times for day $dayOfWeekEnglish: $convenientTimes");

                        convenientDays.clear(); // Clear previous list

                        if (convenientTimes.length == 2) {
                          // Assuming convenientTimes contains two strings: timeStart and timeEnd
                          // final startParts = convenientTimes[0].split(":");
                          // final endParts = convenientTimes[1].split(":");

                          // final timeStart = TimeOfDay(
                          //   hour: int.parse(startParts[0]),
                          //   minute: int.parse(startParts[1]),
                          // );

                          // final timeEnd = TimeOfDay(
                          //   hour: int.parse(endParts[0]),
                          //   minute: int.parse(endParts[1]),
                          // );

                          // Create a ConvenientDayModel object with the given date and times
                          ConvenientDayModel convenientDay = ConvenientDayModel(
                            id: widget.user_id, // Provide a valid id
                            userId: widget.target_id, // Provide a valid userId
                            day:
                                dayOfWeekNumber, // Provide the day of the week number
                            timeStart: convenientTimes[0],
                            timeEnd: convenientTimes[1],
                            createdAt: DateTime.now().toIso8601String(),
                            updatedAt: DateTime.now().toIso8601String(),
                            deletedAt: null, // Use null if not applicable
                          );

                          convenientDays.add(convenientDay);
                        } else {
                          print(
                              "ConvenientTimes should contain exactly two time strings.");
                        }
                      } else {
                        print(
                            "No convenient day found for day $dayOfWeekEnglish");
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                'ช่วงเวลาว่างของอาจารย์: ',
                                style: TextStyle(fontSize: 18),
                              ),
                              // แสดงเวลาที่ดึงมาใน Text widget
                              Text(
                                convenientTimes.isNotEmpty
                                    ? '${convenientTimes[0]} - ${convenientTimes[1]}'
                                    : 'ไม่มีช่วงเวลาว่าง',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (matchingAppointments.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: matchingAppointments.map((appointment) {
                                String startTime = appointment.timeStart;
                                String endTime = appointment.timeEnd;
                                bool isCurrentAppointment =
                                    appointment.id == widget.appointmentId;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isCurrentAppointment
                                          ? 'นัดหมายนี้:'
                                          : 'นัดหมายอื่น:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: isCurrentAppointment
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'เริ่ม: $startTime - สิ้นสุด: $endTime',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 10),
                                    Divider(),
                                    SizedBox(height: 10),
                                  ],
                                );
                              }).toList(),
                            ),
                          Row(
                            children: [
                              Text('ช่วงเวลา', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime:
                                          selectedStartTime ?? TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      setState(() {
                                        selectedStartTime = pickedTime;
                                      });
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'เวลาเริ่ม',
                                    ),
                                    child: Text(
                                      selectedStartTime?.format(context) ??
                                          'เลือกเวลาเริ่ม',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'ถึง',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime:
                                          selectedEndTime ?? TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      setState(() {
                                        selectedEndTime = pickedTime;
                                      });
                                    }
                                  },
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'เวลาจบ',
                                    ),
                                    child: Text(
                                      selectedEndTime?.format(context) ??
                                          'เลือกเวลาจบ',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Divider(),
                          const SizedBox(height: 10),
                          Text(
                            'สถานที่',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.5)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1.0,
                                  blurRadius: 3.0,
                                  offset: const Offset(0.0, 1.0),
                                ),
                              ],
                            ),
                            child: Theme(
                              data: ThemeData(
                                inputDecorationTheme: InputDecorationTheme(
                                  border: InputBorder.none,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: TextFormField(
                                  controller: roomController,
                                  decoration: InputDecoration(
                                    hintText: 'กรอกห้องที่สะดวก',
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily:
                                          GoogleFonts.prompt().fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Divider(),
                          const SizedBox(height: 10),
                          Text(
                            'เหตุผลที่แก้ไข',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.5)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1.0,
                                  blurRadius: 3.0,
                                  offset: const Offset(0.0, 1.0),
                                ),
                              ],
                            ),
                            child: Theme(
                              data: ThemeData(
                                inputDecorationTheme: InputDecorationTheme(
                                  border: InputBorder.none,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกเหตุผลที่แก้ไข';
                                    }
                                    return null;
                                  },
                                  controller: notApprovedController,
                                  decoration: InputDecoration(
                                    hintText: 'กรอกเหตุผลที่แก้ไข',
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily:
                                          GoogleFonts.prompt().fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Divider(),
                          const SizedBox(height: 10),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 116, 211),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  if (_updateAppointment.currentState!
                                      .validate()) {
                                    if (!_validateTimeRange()) {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                        title: "เวลาไม่ถูกต้อง",
                                        desc:
                                            "กรุณาเลือกเวลาเริ่มต้นก่อนเวลาเลิก.",
                                        btnOkOnPress: () {},
                                      ).show();
                                      return;
                                    }

                                    if (_isTimeSlotOverlapping()) {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                        title: "เวลาไม่ถูกต้อง",
                                        desc: "เวลาเลือกทับซ้อนกับนัดหมายอื่น.",
                                        btnOkOnPress: () {},
                                      ).show();
                                      return;
                                    }

                                    if (!_isTimeWithinAvailableRange(
                                        selectedStartTime!, selectedEndTime!)) {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                        title: "เวลาไม่ถูกต้อง",
                                        desc:
                                            "เวลาเลือกอยู่นอกช่วงเวลาที่ว่างของอาจารย์.",
                                        btnOkOnPress: () {},
                                      ).show();
                                      return;
                                    }

                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      animType: AnimType.topSlide,
                                      showCloseIcon: true,
                                      title: "ยืนยันการแก้ไข?",
                                      desc: "คุณต้องการแก้ไขนัดหมายใช่หรือไม่?",
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        try {
                                          AppointmentUpdateModel res =
                                              await updateAppointment();
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.topSlide,
                                            showCloseIcon: true,
                                            title: "แก้ไขนัดหมายสำเร็จ",
                                            btnOkOnPress: () {},
                                          ).show();
                                        } catch (e) {
                                          print(
                                              'Error updating appointment: $e');
                                        }
                                      },
                                    ).show();
                                  }
                                },
                                child: const Center(
                                  child: Text(
                                    "แก้ไขข้อมูลนัดหมาย",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }
                  });
            }
          },
        ),
      ),
    );
  }
}
