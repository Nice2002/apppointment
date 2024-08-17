import 'dart:convert';

import 'package:apppointment/api/appointment_calendar.dart';
import 'package:apppointment/api/appointment_update_api.dart';
import 'package:apppointment/api/convrnirnt_day_api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apppointment/api/appointment_all_api.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Message_Edit extends StatefulWidget {
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

  Message_Edit(
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
  State<Message_Edit> createState() => _Message_EditState();
}

class _Message_EditState extends State<Message_Edit> {
  late Future<List<AppointmentCalendarModel>> futureAppointmentCalendar;
  late Future<List<ConvenientDayModel>>? futureConvenientDay;
  final _updateAppointment = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final detailTitleController = TextEditingController();
  final roomController = TextEditingController();

  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String? appointmentTimeStart;
  String? appointmentTimeEnd;

  List<AppointmentCalendarModel> matchingAppointments = [];
  List<ConvenientDayModel> convenientDays = [];

  get selectedCategoryIndex => null;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    detailTitleController.text = widget.titleDetail;
    roomController.text = widget.location;
    selectedStartTime = _parseTime(widget.timeStart);
    selectedEndTime = _parseTime(widget.timeEnd);
    futureAppointmentCalendar = fetchAppointmentCalendar(widget.user_id);

    initializeDateFormatting('th_TH', null).then((_) {
      setState(() {
        futureAppointmentCalendar = fetchAppointmentCalendar(widget.user_id);
        futureConvenientDay = fetchConvenientDay(
            widget.role_user == 0 ? widget.target_id : widget.user_id);
      });
    });

    // futureAppointmentAll = fetchAppointmentAll(widget.appointmentId);
    // futureAppointmentAll.then((appointment) {
    //   setState(() {
    //     titleController.text = appointment.title ?? '';
    //     detailTitleController.text = appointment.titleDetail ?? '';
    //     roomController.text = appointment.location ?? '';
    //     // อัปเดต _startTimes และ _endTimes ด้วยข้อมูลจาก appointment
    //     _startTimes = [appointment.timeStart ?? '08:00'];
    //     _endTimes = [appointment.timeEnd ?? '12:00'];
    //     strattime = appointment.timeStart;
    //     endtime = appointment.timeEnd;
    //   });
    // });
  }

  @override
  void dispose() {
    titleController.dispose();
    detailTitleController.dispose();
    roomController.dispose();
    super.dispose();
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
    return DateFormat('h:mm a').format(dateTime); // ใช้รูปแบบ 12-hour AM/PM
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
        // ข้ามการตรวจสอบนัดหมายนี้
        if (appointment.id == widget.appointmentId) continue;

        final appointmentStartTime = _parseTime(appointment.timeStart);
        final appointmentEndTime = _parseTime(appointment.timeEnd);

        if (appointmentStartTime != null && appointmentEndTime != null) {
          final appointmentStartMinutes =
              appointmentStartTime.hour * 60 + appointmentStartTime.minute;
          final appointmentEndMinutes =
              appointmentEndTime.hour * 60 + appointmentEndTime.minute;

          // ตรวจสอบการทับซ้อน
          if ((newStartMinutes < appointmentEndMinutes &&
                  newEndMinutes > appointmentStartMinutes) ||
              (newStartMinutes == appointmentStartMinutes &&
                  newEndMinutes == appointmentEndMinutes)) {
            return true; // พบการทับซ้อน
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

  Future<AppointmentUpdateModel> UpdateAppointment() async {
    final appointment_id = widget.appointmentId;
    final title = titleController.text;
    final titleDetail = detailTitleController.text;
    final location = roomController.text;
    final timeStart = _formatTimeOfDay(selectedStartTime!);
    final timeEnd = _formatTimeOfDay(selectedEndTime!);

    final url =
        Uri.parse('https://appt-cis.smt-online.com/api/appointment/update');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + globals.jwtToken
    };

    final body = jsonEncode(
      {
        'id': appointment_id,
        'title': title,
        'title_detail': titleDetail,
        'location': location,
        'appointments': [
          {
            'time_start': timeStart,
            'time_end': timeEnd,
          }
        ],
      },
    );

    final response = await http.post(url, headers: headers, body: body);

    print("Request body: $body");
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

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
      throw Exception('Failed to insert appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black,
        title: const Text('แก้ไขข้อมูลการนัดหมาย'),
      ),
      body: SingleChildScrollView(
        child: Form(
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

                  print("Selected date: $selectedDate");

                  final Map<String, int> dayOfWeekMap = {
                    'Monday': 1,
                    'Tuesday': 2,
                    'Wednesday': 3,
                    'Thursday': 4,
                    'Friday': 5,
                  };

                  String dayOfWeekEnglish =
                      DateFormat('EEEE').format(selectedDate);
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
                          child: Text(
                              'เกิดข้อผิดพลาด: ${convenientSnapshot.error}'),
                        );
                      } else if (!convenientSnapshot.hasData ||
                          convenientSnapshot.data!.isEmpty) {
                        return Center(child: Text('ไม่มีข้อมูล'));
                      } else {
                        List<ConvenientDayModel> convenientDay =
                            convenientSnapshot.data!;

                        // แสดงข้อมูล convenientDay ทั้งหมดที่ได้มา
                        print("ConvenientDayModel data: $convenientDay");

                        ConvenientDayModel? matchingConvenientDay =
                            convenientDay.firstWhere(
                                (day) => day.day == dayOfWeekNumber);

                        List<String> convenientTimes = [];

                        if (matchingConvenientDay != null) {
                          print("Matching day: $matchingConvenientDay");
                          print(
                              "Time start: ${matchingConvenientDay.timeStart}");
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
                            ConvenientDayModel convenientDay =
                                ConvenientDayModel(
                              id: widget.user_id, // Provide a valid id
                              userId:
                                  widget.target_id, // Provide a valid userId
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            if (matchingAppointments.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    matchingAppointments.map((appointment) {
                                  String startTime = appointment.timeStart;
                                  String endTime = appointment.timeEnd;
                                  bool isCurrentAppointment =
                                      appointment.id == widget.appointmentId;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                            Text(
                              'เรื่องที่ต้องการนัดหมาย',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(10.0),
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextFormField(
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'เรื่องการนัดหมาย',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(),
                            const SizedBox(height: 10),
                            Text(
                              'รายละเอียดการนัดหมาย',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 210,
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
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: TextFormField(
                                    controller: detailTitleController,
                                    keyboardType: TextInputType.text,
                                    maxLines: 6,
                                    maxLength: 150,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(150)
                                    ],
                                    decoration: InputDecoration(
                                      hintText: 'กรอกรายละเอียดของเรื่อง',
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
                            Row(
                              children: [
                                Text('ช่วงเวลา',
                                    style: TextStyle(fontSize: 18)),
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
                                        initialTime: selectedStartTime ??
                                            TimeOfDay.now(),
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
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 116, 211),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  onTap: () {
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
                                          desc:
                                              "เวลาเลือกทับซ้อนกับนัดหมายอื่น.",
                                          btnOkOnPress: () {},
                                        ).show();
                                        return;
                                      }

                                      if (!_isTimeWithinAvailableRange(
                                          selectedStartTime!,
                                          selectedEndTime!)) {
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
                                        desc:
                                            "คุณต้องการแก้ไขนัดหมายใช่หรือไม่?",
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () async {
                                          try {
                                            AppointmentUpdateModel res =
                                                await UpdateAppointment();
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
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String defaultValue, List<String> times,
      ValueChanged<String?> onChanged) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2.0,
            blurRadius: 8.0,
            offset: const Offset(0.0, 1.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Align(
          alignment: Alignment.center,
          child: DropdownButton<String>(
            value: times.contains(defaultValue) ? defaultValue : null,
            icon: const Icon(Icons.arrow_drop_down, size: 30),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(
              color: Colors.black,
              fontFamily: GoogleFonts.prompt().fontFamily,
            ),
            underline: Container(height: 0, color: Colors.transparent),
            onChanged: onChanged,
            items: times.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(value, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
