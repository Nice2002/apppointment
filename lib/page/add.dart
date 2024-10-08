import 'dart:convert';
import 'dart:ffi';
import 'package:apppointment/api/appointment_calendar.dart';
import 'package:apppointment/api/appointment_insert_api.dart';
import 'package:apppointment/api/convrnirnt_day_api.dart';
import 'package:apppointment/api/user_api.dart';
import 'package:apppointment/api/user_student_api.dart';
import 'package:apppointment/api/user_teacher_api.dart';
import 'package:apppointment/page/dialog_link.dart';
import 'package:apppointment/page/webview_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart'; // Import the package

import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class Add extends StatefulWidget {
  final int user_id;
  final int roleUser;
  const Add(this.user_id, this.roleUser, {Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  late Future<UserModel> futureUser;
  late Future<List<UserTeacherModel>> futureUserTeacher;
  late Future<List<UserStudentModel>> futureUserStudent;
  late Future<List<ConvenientDayModel>>? futureConvenientDay;
  late Future<List<AppointmentCalendarModel>> futureAppointmentCalendar_1;
  late Future<List<AppointmentCalendarModel>> futureAppointmentCalendar_2;
  List<UserStudentModel> filteredStudents = [];
  List<AppointmentCalendarModel> matchingAppointments = [];
  List<ConvenientDayModel> convenientDays = [];
  List<ConvenientDayModel> convenientDays_ = [];

  final _appointmentform = GlobalKey<FormState>();

  UserTeacherModel? _selectedTeacher;
  UserStudentModel? _selectedStudent;
  String? _selectedName;
  String? _selectedRoom;
  int? _selectedUser_id;
  String? selectedCourse;
  String? selectedYear;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser(widget.user_id);
    futureUserTeacher = fetchUserTeacher();
    futureUserStudent = fetchUserStudent();
    futureConvenientDay = null;
    futureAppointmentCalendar_1 = fetchAppointmentCalendar(widget.user_id);
    futureAppointmentCalendar_2 = fetchAppointmentCalendar(_selectedUser_id);
  }

  TextEditingController _textEditingController = TextEditingController();
  // ฟังก์ชันที่ใช้เพื่อแปลงวันที่ให้เป็นค่าตามเงื่อนไข
  int convertDateToValue(DateTime date) {
    // ตรวจสอบว่าวันที่อยู่ในช่วงใดและให้ค่าตามเงื่อนไข
    if (date.month <= 6) {
      return 2;
    } else {
      return 1;
    }
  }

  int convertYearToValue(int year) {
    // เอาแต่ปี พ.ศ. ของเลข 2 ตัวท้าย
    int buddhistYear = (year + 543) % 100;
    return buddhistYear;
  }

  DateTime? _selectedDay;
  List<String> _startTimes = [];
  List<String> _endTimes = [];
  Map<DateTime, TimeOfDay?> TimeStartControllers =
      {}; // Map to store start times for each day
  Map<DateTime, TimeOfDay?> TimeEndControllers =
      {}; // Map to store end times for each day

  List<String> _startTimes_2 = ['08:00', '09:00', '10:00'];
  List<String> _endTimes_2 = ['12:00', '13:00', '14:00'];

  void _onDaySelected(List<ConvenientDayModel> convenientDays,
      DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;

      // เคลียร์รายการเวลาทั้งหมดก่อนเพื่อเตรียมการอัปเดต
      _startTimes.clear();
      _endTimes.clear();

      // ค้นหาและเพิ่มรายการเวลาที่เกี่ยวข้องกับวันที่เลือก
      convenientDays.forEach((day) {
        if (day.day == selectedDay.weekday) {
          _startTimes.add(day.timeStart);
          _endTimes.add(day.timeEnd);
        }
      });

      // อัปเดตค่าเริ่มต้นของเวลา
      strattime = _startTimes.isNotEmpty ? _startTimes.first : 'เลือกเวลาเริ่ม';
      endtime = _endTimes.isNotEmpty ? _endTimes.first : 'เลือกเวลาจบ';
    });
  }

  bool _isWeekend(List<AppointmentCalendarModel> appointmentCalendar,
      List<ConvenientDayModel> convenientDays, DateTime day, DateTime today) {
    // เช็คว่าเป็นวันสุดสัปดาห์หรือไม่ (วันเสาร์หรือวันอาทิตย์)
    if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
      return true;
    }
    DateTime threeDaysFromToday = today.add(Duration(days: 3));
    if (day.isBefore(threeDaysFromToday)) {
      return true;
    } // เช็คว่าวันนี้เป็นวันสะดวกหรือไม่
    if (convenientDays
        .any((convenientDay) => convenientDay.day == day.weekday)) {
      return false; // วันนี้ไม่ว่าง
    }

    // if(appointmentCalendar.any(appointmentCalendar) => appointmentCalendar)
    return true;
  }

  void _onDaySelectedStudent(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;

      // เคลียร์รายการเวลาทั้งหมดก่อนเพื่อเตรียมการอัปเดต
      _startTimes.clear();
      _endTimes.clear();

      // ค้นหาและเพิ่มรายการเวลาที่เกี่ยวข้องกับวันที่เลือก
      convenientDays.forEach((day) {
        if (day.day == selectedDay.weekday) {
          _startTimes.add(day.timeStart);
          _endTimes.add(day.timeEnd);
        }
      });

      // อัปเดตค่าเริ่มต้นของเวลา
      strattime = _startTimes.isNotEmpty ? _startTimes.first : 'เลือกเวลาเริ่ม';
      endtime = _endTimes.isNotEmpty ? _endTimes.first : 'เลือกเวลาจบ';
    });
  }

  bool _isWeekendStudent(DateTime day, DateTime today) {
    if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
      return true;
    }
    DateTime threeDaysFromToday = today.add(Duration(days: 3));
    if (day.isBefore(threeDaysFromToday)) {
      return true;
    } // เช็คว่าวันนี้เป็นวันสะดวกหรือไม่

    return false;
  }

  DateTime today = DateTime.now();
  String? strattime;
  String? endtime;

  int? _selectedTitleIndex;
  String? selectedTitleText;
  int? _selectedRoomIndex;
  String? selectedRoomText;
  TextEditingController _otherTitleController = TextEditingController();
  TextEditingController _detailTitleController = TextEditingController();
  TextEditingController _RoomController = TextEditingController();

  void _titleCheckboxChanged(int index, String titleText) {
    setState(() {
      if (_selectedTitleIndex == index) {
        _selectedTitleIndex = -1;
        selectedTitleText = null; // ยกเลิกการเลือก
      } else {
        _selectedTitleIndex = index;
        selectedTitleText = titleText;
      }
    });
  }

  void _roomCheckboxChanged(int index, String titleText) {
    setState(() {
      if (_selectedRoomIndex == index) {
        _selectedRoomIndex = -1;
        selectedRoomText = titleText;
      } else {
        _selectedRoomIndex = index;
        selectedRoomText = titleText;
      }
    });
  }

  int status = -1;
  void _statusCheckboxChanged(int index) {
    setState(() {
      if (status == index) {
        status = -1;
      } else {
        status = index;
      }
    });
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
        // if (appointment.id == widget.appointmentId) continue;

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
    print(convenientDays_);
    if (convenientDays_.isEmpty) return false;

    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    print("Selected Start Minutes: $startMinutes, End Minutes: $endMinutes");

    for (var day in convenientDays_) {
      print("Checking availability for day: ${day.day}");
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

  Future<AppointmentInsertModel> fetchAppointmentInsert() async {
    final userId = widget.user_id?.toString() ?? '';
    final targetId = _selectedUser_id?.toString() ?? '';
    final String title;
    if (_selectedTitleIndex == 1 || _selectedTitleIndex == 2) {
      title = selectedTitleText ?? '';
    } else {
      title = _otherTitleController.text;
    }
    final titleDetail = _detailTitleController.text;
    final String location;
    if (_selectedRoomIndex == 1) {
      location = selectedRoomText ?? '';
    } else {
      location = _RoomController.text;
    }
    final priorityLevel = status.toString();

    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay!);

    String _formatTimeOfDay(TimeOfDay timeOfDay) {
      // Convert TimeOfDay to DateTime
      final now = DateTime.now();
      final dateTime = DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

      // Format DateTime as hh:mm:ss A (12-hour clock with AM/PM)
      final formatter = DateFormat('hh:mm:ss a');
      return formatter.format(dateTime);
    }

    final startTime = _formatTimeOfDay(selectedStartTime!);
    final endTime = _formatTimeOfDay(selectedEndTime!);

    final url =
        Uri.parse('https://appt-cis.smt-online.com/api/appointment/insert');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + globals.jwtToken
    };

    final body = jsonEncode({
      'user_id': userId,
      'target_id': targetId,
      'appointments': [
        {
          'date': formattedDate,
          'time_start': startTime,
          'time_end': endTime,
        }
      ],
      'title': title,
      'title_detail': titleDetail,
      'location': location,
      'priority_level': priorityLevel,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final appointmentInsertModel =
          AppointmentInsertModel.fromJson(json.decode(response.body));
      print('Appointment Insert Model: $appointmentInsertModel');
      return appointmentInsertModel;
    } else {
      print(
          'Failed to insert appointment. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to insert appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black, // สีของเงา
        title: const Text('เพิ่มข้อมูลการนัดหมาย'),
      ),
      body: SingleChildScrollView(
        child: widget.roleUser == 0
            ? _buildWidgetForStudent()
            : _buildWidgetForTeacher(),
      ),
    );
  }

  Widget _buildWidgetForStudent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FutureBuilder<List<UserTeacherModel>>(
          future: futureUserTeacher,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (userSnapshot.hasError) {
              return Center(
                  child: Text('เกิดข้อผิดพลาด: ${userSnapshot.error}'));
            } else if (!userSnapshot.hasData) {
              return Center(child: Text('ไม่มีข้อมูล'));
            } else {
              final userTeachers = userSnapshot.data!;
              DateTime currentDate = DateTime.now();
              int resultDate = convertDateToValue(currentDate);
              // int resultDate = 1;
              DateTime currentYear = DateTime.now();
              int resultYear = convertYearToValue(currentYear.year);
              // print(resultDate);
              // print(resultYear);
              ListView.builder(
                itemCount: userTeachers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${userTeachers[index].prefix} ${userTeachers[index].firstName} ${userTeachers[index].lastName}'),
                    onTap: () {
                      // เมื่อผู้ใช้เลือกอาจารย์
                      // ใส่ชื่ออาจารย์ที่เลือกใน TextField
                      setState(() {
                        // สมมติว่าเมื่อเลือกอาจารย์แล้ว คุณต้องการให้ชื่ออาจารย์ปรากฏใน TextField
                        // จะให้ใช้ตัวแปร _selectedTeacher เก็บข้อมูลอาจารย์ที่เลือก
                        _selectedTeacher = userTeachers[index];
                        print(userTeachers[index].teachingSchedulLlink);
                        print(_selectedTeacher!.email);
                        // _textEditingController.text =
                        //     '${_selectedTeacher.prefix} ${_selectedTeacher.firstName} ${_selectedTeacher.lastName}';
                      });
                    },
                  );
                },
              );
              return Form(
                key: _appointmentform,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'เลือกอาจารย์ที่ต้องการเข้าพบ',
                          style: TextStyle(
                            fontSize: 18,
                            // color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return userTeachers
                            .where(
                              (user) => '${user.firstName} ${user.lastName}'
                                  .toLowerCase()
                                  .contains(
                                    textEditingValue.text.toLowerCase(),
                                  ),
                            )
                            .map((user) =>
                                '${user.prefix} ${user.firstName} ${user.lastName}')
                            .toList();
                      },
                      onSelected: (String selection) {
                        final selectedTeacher = userTeachers.firstWhere(
                          (user) =>
                              '${user.prefix} ${user.firstName} ${user.lastName}' ==
                              selection,
                        );

                        setState(() {
                          _selectedName = selection;
                          _selectedRoom = selectedTeacher.teacherRoom;
                          _selectedUser_id = selectedTeacher.id;

                          futureConvenientDay =
                              fetchConvenientDay(_selectedUser_id!);
                        });

                        // debugPrint('teacher_id $_selectedUser_id');
                        // debugPrint('Room: ${selectedTeacher.teacherRoom}');
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        _textEditingController = fieldTextEditingController;
                        return Container(
                          height: 55,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.5),
                              // const Color.fromARGB(255, 13, 187, 158),
                            ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: _textEditingController,
                              focusNode: fieldFocusNode,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'ค้นหาชื่ออาจารย์',
                              ),
                              onSubmitted: (String value) {
                                onFieldSubmitted();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    if (_selectedName != null)
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          onTap: () {
                            final selectedTeacher = userTeachers.firstWhere(
                              (user) =>
                                  '${user.prefix} ${user.firstName} ${user.lastName}' ==
                                  _selectedName,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebviewPage(
                                    selectedTeacher.teachingSchedulLlink,
                                    resultDate,
                                    resultYear),
                              ),
                            );
                          },
                          child: Text(
                            'ลิงก์ตารางสอน: $_selectedName',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'เรื่องที่ต้องการนัดหมาย',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: _selectedTitleIndex == 1,
                        onChanged: (value) {
                          _titleCheckboxChanged(1, 'โครงงาน');
                        },
                        title: Text('โครงงาน'),
                      ),
                    ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: _selectedTitleIndex == 2,
                        onChanged: (value) {
                          _titleCheckboxChanged(2, 'งานกิจกรรม');
                        },
                        title: Text('งานกิจกรรม'),
                      ),
                    ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: _selectedTitleIndex == 3,
                        onChanged: (value) {
                          _titleCheckboxChanged(3, '${_otherTitleController}');
                        },
                        title: Text('อื่นๆ'),
                      ),
                    ),
                    if (_selectedTitleIndex == 3)
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
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
                                  return 'กรุณากรอกเรื่อง';
                                }
                                return null;
                              },
                              controller:
                                  _otherTitleController, // ใช้ TextEditingController
                              decoration: InputDecoration(
                                hintText: 'กรอกเรื่อง',
                                hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: GoogleFonts.prompt().fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'รายละเอียดการนัดหมาย',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                          // const Color.fromARGB(255, 13, 187, 158),
                        ),
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
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกรายระเอียด';
                              }
                              return null;
                            },
                            controller: _detailTitleController,
                            maxLines: 6,
                            maxLength: 150,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(150)
                            ],
                            decoration: InputDecoration(
                              hintText: 'กรอกรายละเอียดของเรื่อง',
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                fontFamily: GoogleFonts.prompt().fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        // const Icon(
                        //   Icons.calendar_month,
                        //   size: 25,
                        // ),
                        // const SizedBox(
                        //   width: 3,
                        // ),
                        Text(
                          'เลือกวันที่ต้องการนัดหมาย',
                          style: TextStyle(
                            fontSize: 18,
                            // color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FutureBuilder<List<AppointmentCalendarModel>>(
                      future: futureAppointmentCalendar_1,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('ไม่มีข้อมูล'));
                        } else {
                          List<AppointmentCalendarModel> appointmentCalendar =
                              snapshot.data!;

                          final formattedDate = _selectedDay != null
                              ? DateFormat('yyyy-MM-dd').format(_selectedDay!)
                              : '';

                          DateTime? formattedDateAsDateTime = _selectedDay !=
                                  null
                              ? DateFormat('yyyy-MM-dd').parse(formattedDate)
                              : null;

                          final Map<String, int> dayOfWeekMap = {
                            'Monday': 1,
                            'Tuesday': 2,
                            'Wednesday': 3,
                            'Thursday': 4,
                            'Friday': 5,
                          };

                          int? dayOfWeekNumber;

                          if (formattedDateAsDateTime != null) {
                            String dayOfWeekEnglish = DateFormat('EEEE')
                                .format(formattedDateAsDateTime);
                            dayOfWeekNumber =
                                dayOfWeekMap[dayOfWeekEnglish] ?? 0;

                            print(
                                "Selected date: $formattedDateAsDateTime ($dayOfWeekEnglish - $dayOfWeekNumber)");
                          } else {
                            print('No date selected');
                          }

                          matchingAppointments.clear();

                          if (formattedDateAsDateTime != null) {
                            for (var appointment in appointmentCalendar) {
                              if (appointment.date.year ==
                                      formattedDateAsDateTime.year &&
                                  appointment.date.month ==
                                      formattedDateAsDateTime.month &&
                                  appointment.date.day ==
                                      formattedDateAsDateTime.day) {
                                matchingAppointments.add(appointment);
                              }
                            }
                          }

                          return FutureBuilder<List<ConvenientDayModel>>(
                            future: futureConvenientDay,
                            builder: (context, convenientSnapshot) {
                              if (convenientSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (convenientSnapshot.hasError) {
                                return Center(
                                  child: Text(
                                      'เกิดข้อผิดพลาด: ${convenientSnapshot.error}'),
                                );
                              } else if (!convenientSnapshot.hasData) {
                                return Center(
                                    child: Text(
                                        'กรุณาเลือกอาจารย์ที่อยากนัดหมายก่อน'));
                              } else {
                                final List<ConvenientDayModel> convenientDays =
                                    convenientSnapshot.data!;

                                ConvenientDayModel? matchingConvenientDay =
                                    convenientDays.firstWhereOrNull(
                                  (day) => day.day == (dayOfWeekNumber ?? 0),
                                );
                                List<String> convenientTimes = [];

                                if (matchingConvenientDay != null) {
                                  convenientTimes = [
                                    matchingConvenientDay.timeStart,
                                    matchingConvenientDay.timeEnd
                                  ];

                                  convenientDays_.clear();

                                  if (convenientTimes.length == 2) {
                                    ConvenientDayModel convenientDay =
                                        ConvenientDayModel(
                                      id: widget.user_id,
                                      userId: _selectedUser_id ?? 0,
                                      day: dayOfWeekNumber ?? 0,
                                      timeStart: convenientTimes[0],
                                      timeEnd: convenientTimes[1],
                                      createdAt:
                                          DateTime.now().toIso8601String(),
                                      updatedAt:
                                          DateTime.now().toIso8601String(),
                                      deletedAt: null,
                                    );

                                    convenientDays_.add(convenientDay);
                                  }
                                }

                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 2.0,
                                            blurRadius: 5.0,
                                            offset: const Offset(0.0, 1.0),
                                          ),
                                        ],
                                      ),
                                      child: TableCalendar<String>(
                                        headerStyle: const HeaderStyle(
                                          formatButtonVisible: false,
                                          titleCentered: true,
                                        ),
                                        rowHeight: 45,
                                        availableGestures:
                                            AvailableGestures.all,
                                        focusedDay: DateTime.now(),
                                        firstDay: DateTime.utc(2010, 10, 16),
                                        lastDay: DateTime.utc(2030, 3, 14),
                                        selectedDayPredicate: (day) =>
                                            isSameDay(day, _selectedDay),
                                        calendarStyle: const CalendarStyle(
                                          outsideDaysVisible: false,
                                        ),
                                        onDaySelected:
                                            (selectedDay, focusedDay) {
                                          _onDaySelected(convenientDays,
                                              selectedDay, focusedDay);
                                        },
                                        enabledDayPredicate: (day) {
                                          bool isWeekend = _isWeekend(
                                              appointmentCalendar,
                                              convenientDays,
                                              day,
                                              DateTime.now());
                                          return !isWeekend;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'ช่วงเวลา',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text('ช่วงเวลาว่างของอาจารย์'),
                                          ],
                                        ),
                                        if (_selectedDay != null) ...[
                                          for (var convenient in convenientDays)
                                            if (convenient.day ==
                                                _selectedDay!.weekday)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                        'เวลา: ${convenient.timeStart}'),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Text(" - "),
                                                    ),
                                                    Text(
                                                        'เวลา: ${convenient.timeEnd}'),
                                                  ],
                                                ),
                                              ),
                                        ],
                                        if (matchingAppointments.isNotEmpty)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: matchingAppointments
                                                .map((appointment) {
                                              String startTime =
                                                  appointment.timeStart;
                                              String endTime =
                                                  appointment.timeEnd;

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'นัดหมายอื่น:',
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'เริ่ม: $startTime - สิ้นสุด: $endTime',
                                                  ),
                                                  SizedBox(height: 10),
                                                  Divider(),
                                                  SizedBox(height: 10),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              TimeOfDay? pickedTime =
                                                  await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    selectedStartTime ??
                                                        TimeOfDay.now(),
                                              );
                                              if (pickedTime != null) {
                                                setState(() {
                                                  selectedStartTime =
                                                      pickedTime;
                                                });
                                              }
                                            },
                                            child: InputDecorator(
                                              decoration: InputDecoration(
                                                labelText: 'เวลาเริ่ม',
                                              ),
                                              child: Text(
                                                selectedStartTime
                                                        ?.format(context) ??
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
                                                initialTime: selectedEndTime ??
                                                    TimeOfDay.now(),
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
                                                selectedEndTime
                                                        ?.format(context) ??
                                                    'เลือกเวลาจบ',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ห้อง',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: _selectedRoomIndex == 1,
                        onChanged: (value) {
                          _roomCheckboxChanged(1, '${_selectedRoom}');
                        },
                        title: Text('ห้องพักอาจารย์'),
                      ),
                    ),
                    if (_selectedRoomIndex == 1)
                      Container(
                        child: Text(
                          'สถานที่ : ${_selectedRoom}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: _selectedRoomIndex == 2,
                        onChanged: (value) {
                          _roomCheckboxChanged(2, '${_RoomController}');
                        },
                        title: Text('อื่นๆ'),
                      ),
                    ),
                    if (_selectedRoomIndex == 2)
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
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
                                  return 'กรุณากรอกห้องที่สะดวก';
                                }
                                return null;
                              },
                              controller: _RoomController,
                              decoration: InputDecoration(
                                hintText: 'กรอกห้องที่สะดวก',
                                hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: GoogleFonts.prompt().fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'สถานะ',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: status == 0,
                        onChanged: (value) {
                          _statusCheckboxChanged(0);
                        },
                        title: Text('ปกติ'),
                      ),
                    ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: status == 1,
                        onChanged: (value) {
                          _statusCheckboxChanged(1);
                        },
                        title: Text('เร่งด่วน'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
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
                            if (_appointmentform.currentState!.validate()) {
                              if (!_validateTimeRange()) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.topSlide,
                                  showCloseIcon: true,
                                  title: "เวลาไม่ถูกต้อง",
                                  desc: "กรุณาเลือกเวลาเริ่มต้นก่อนเวลาเลิก.",
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
                                title: "ยืนยันการขอนัดหมาย?",
                                desc: "คุณต้องการขอนัดหมายใช่หรือไม่?",
                                btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                                  AppointmentInsertModel res =
                                      await fetchAppointmentInsert();
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.topSlide,
                                    showCloseIcon: true,
                                    title: "ขอนัดหมายสำเร็จ",
                                    btnOkOnPress: () {},
                                  ).show();
                                },
                              ).show();
                            }
                            print('user_id: ${widget.user_id}');
                            print('target_id: ${_selectedUser_id}');
                            if (_selectedTitleIndex == 1 ||
                                _selectedTitleIndex == 2) {
                              print('title: ${selectedTitleText}');
                            } else {
                              print('title: ${_otherTitleController.text}');
                            }
                            print(
                                'title_detail: ${_detailTitleController.text}');

// ฟังก์ชั่นเพื่อฟอร์แมตเวลา
                            String _formatTimeOfDay(TimeOfDay timeOfDay) {
                              // Convert TimeOfDay to DateTime
                              final now = DateTime.now();
                              final dateTime = DateTime(now.year, now.month,
                                  now.day, timeOfDay.hour, timeOfDay.minute);

                              // Format DateTime as hh:mm:ss A (12-hour clock with AM/PM)
                              final formatter = DateFormat('hh:mm:ss a');
                              return formatter.format(dateTime);
                            }

                            final startTime =
                                _formatTimeOfDay(selectedStartTime!);
                            final endTime = _formatTimeOfDay(selectedEndTime!);
                            print('startTime: ${startTime}');
                            print('endTime: ${endTime}');

                            if (_selectedRoomIndex == 1) {
                              print('room: ${selectedRoomText}');
                            } else {
                              print('room: ${_RoomController.text}');
                            }
                            print('priority_level: ${status}');
                          },
                          child: const Center(
                            child: Text(
                              "เพิ่มข้อมูลนัดหมาย",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildWidgetForTeacher() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FutureBuilder<List<UserStudentModel>>(
          future: futureUserStudent,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (userSnapshot.hasError) {
              return Center(
                  child: Text('เกิดข้อผิดพลาด: ${userSnapshot.error}'));
            } else if (!userSnapshot.hasData) {
              return Center(child: Text('ไม่มีข้อมูล'));
            } else {
              final userStudents = userSnapshot.data!;

              return Form(
                key: _appointmentform,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'กรุณาเลือกหลักสูตรและชั้นปีก่อนค้นหาชื่อ',
                          style: GoogleFonts.kanit(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'เลือกหลักสูตร',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    DropdownButton<String>(
                      hint: Text('เลือกหลักสูตร'),
                      value: selectedCourse,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCourse = newValue;
                          _filterStudents(userStudents);
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: '1',
                          child: Text('วิทยาการคอมพิวเตอร์'),
                        ),
                        DropdownMenuItem<String>(
                          value: '2',
                          child: Text('วิทยาการข้อมูล'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'เลือกชั้นปี',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    DropdownButton<String>(
                      hint: Text('เลือกชั้นปี'),
                      value: selectedYear,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedYear = newValue;
                          _filterStudents(userStudents);
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: '64',
                          child: Text('ปี 4'),
                        ),
                        DropdownMenuItem<String>(
                          value: '65',
                          child: Text('ปี 3'),
                        ),
                        DropdownMenuItem<String>(
                          value: '66',
                          child: Text('ปี 2'),
                        ),
                        DropdownMenuItem<String>(
                          value: '67',
                          child: Text('ปี 1'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'เลือกนิสิตที่ต้องการเข้าพบ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return filteredStudents
                            .where((user) =>
                                '${user.firstName} ${user.lastName} ${user.studentId}'
                                    .toLowerCase()
                                    .contains(
                                      textEditingValue.text.toLowerCase(),
                                    ))
                            .map((user) =>
                                '${user.prefix} ${user.firstName} ${user.lastName} (${user.studentId})')
                            .toList();
                      },
                      onSelected: (String selection) {
                        final selectedStudent = filteredStudents.firstWhere(
                          (user) =>
                              '${user.prefix} ${user.firstName} ${user.lastName} (${user.studentId})' ==
                              selection,
                        );

                        setState(() {
                          _selectedStudent = selectedStudent;
                          _selectedUser_id = selectedStudent.id;

                          futureConvenientDay =
                              fetchConvenientDay(widget.user_id);
                        });
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        _textEditingController = fieldTextEditingController;
                        return Container(
                          height: 55,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.5),
                            ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: _textEditingController,
                              focusNode: fieldFocusNode,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'ค้นหาชื่อนิสิต',
                              ),
                              onSubmitted: (String value) {
                                onFieldSubmitted();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'เรื่องที่ต้องการนัดหมาย',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: _selectedTitleIndex == 1,
                        onChanged: (value) {
                          _titleCheckboxChanged(1, 'โครงงาน');
                        },
                        title: Text('โครงงาน'),
                      ),
                    ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: _selectedTitleIndex == 2,
                        onChanged: (value) {
                          _titleCheckboxChanged(2, 'งานกิจกรรม');
                        },
                        title: Text('งานกิจกรรม'),
                      ),
                    ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: _selectedTitleIndex == 3,
                        onChanged: (value) {
                          _titleCheckboxChanged(3, '${_otherTitleController}');
                        },
                        title: Text('อื่นๆ'),
                      ),
                    ),
                    if (_selectedTitleIndex == 3)
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
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
                                  return 'กรุณากรอกเรื่อง';
                                }
                                return null;
                              },
                              controller:
                                  _otherTitleController, // ใช้ TextEditingController
                              decoration: InputDecoration(
                                hintText: 'กรอกเรื่อง',
                                hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: GoogleFonts.prompt().fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'รายละเอียดการนัดหมาย',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                          // const Color.fromARGB(255, 13, 187, 158),
                        ),
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
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกรายละเอียด';
                              }
                              return null;
                            },
                            controller: _detailTitleController,
                            maxLines: 6,
                            maxLength: 150,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(150)
                            ],
                            decoration: InputDecoration(
                              hintText: 'กรอกรายละเอียดของเรื่อง',
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                fontFamily: GoogleFonts.prompt().fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        // const Icon(
                        //   Icons.calendar_month,
                        //   size: 25,
                        // ),
                        // const SizedBox(
                        //   width: 3,
                        // ),
                        Text(
                          'เลือกวันที่ต้องการนัดหมาย',
                          style: TextStyle(
                            fontSize: 18,
                            // color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FutureBuilder<List<AppointmentCalendarModel>>(
                      future: futureAppointmentCalendar_1,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('ไม่มีข้อมูล'));
                        } else {
                          List<AppointmentCalendarModel> appointmentCalendar =
                              snapshot.data!;

                          final formattedDate = _selectedDay != null
                              ? DateFormat('yyyy-MM-dd').format(_selectedDay!)
                              : '';

                          DateTime? formattedDateAsDateTime = _selectedDay !=
                                  null
                              ? DateFormat('yyyy-MM-dd').parse(formattedDate)
                              : null;

                          final Map<String, int> dayOfWeekMap = {
                            'Monday': 1,
                            'Tuesday': 2,
                            'Wednesday': 3,
                            'Thursday': 4,
                            'Friday': 5,
                          };

                          int? dayOfWeekNumber;

                          if (formattedDateAsDateTime != null) {
                            String dayOfWeekEnglish = DateFormat('EEEE')
                                .format(formattedDateAsDateTime);
                            dayOfWeekNumber =
                                dayOfWeekMap[dayOfWeekEnglish] ?? 0;

                            print(
                                "Selected date: $formattedDateAsDateTime ($dayOfWeekEnglish - $dayOfWeekNumber)");
                          } else {
                            print('No date selected');
                          }

                          matchingAppointments.clear();

                          if (formattedDateAsDateTime != null) {
                            for (var appointment in appointmentCalendar) {
                              if (appointment.date.year ==
                                      formattedDateAsDateTime.year &&
                                  appointment.date.month ==
                                      formattedDateAsDateTime.month &&
                                  appointment.date.day ==
                                      formattedDateAsDateTime.day) {
                                matchingAppointments.add(appointment);
                              }
                            }
                          }
                          return FutureBuilder<List<ConvenientDayModel>>(
                            future: futureConvenientDay,
                            builder: (context, convenientSnapshot) {
                              if (convenientSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (convenientSnapshot.hasError) {
                                return Center(
                                  child: Text(
                                      'เกิดข้อผิดพลาด: ${convenientSnapshot.error}'),
                                );
                              } else if (!convenientSnapshot.hasData) {
                                return Center(
                                    child: Text(
                                        'กรุณาเลือกนิสิตที่อยากนัดหมายก่อน'));
                              } else {
                                final List<ConvenientDayModel> convenientDays =
                                    convenientSnapshot.data!;

                                ConvenientDayModel? matchingConvenientDay =
                                    convenientDays.firstWhereOrNull(
                                  (day) => day.day == (dayOfWeekNumber ?? 0),
                                );
                                List<String> convenientTimes = [];

                                if (matchingConvenientDay != null) {
                                  convenientTimes = [
                                    matchingConvenientDay.timeStart,
                                    matchingConvenientDay.timeEnd
                                  ];

                                  convenientDays_.clear();

                                  if (convenientTimes.length == 2) {
                                    ConvenientDayModel convenientDay =
                                        ConvenientDayModel(
                                      id: widget.user_id,
                                      userId: _selectedUser_id ?? 0,
                                      day: dayOfWeekNumber ?? 0,
                                      timeStart: convenientTimes[0],
                                      timeEnd: convenientTimes[1],
                                      createdAt:
                                          DateTime.now().toIso8601String(),
                                      updatedAt:
                                          DateTime.now().toIso8601String(),
                                      deletedAt: null,
                                    );

                                    convenientDays_.add(convenientDay);
                                  }
                                }
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 2.0,
                                            blurRadius: 5.0,
                                            offset: const Offset(0.0, 1.0),
                                          ),
                                        ],
                                      ),
                                      child: TableCalendar<String>(
                                        headerStyle: const HeaderStyle(
                                          formatButtonVisible: false,
                                          titleCentered: true,
                                        ),
                                        rowHeight: 45,
                                        availableGestures:
                                            AvailableGestures.all,
                                        focusedDay: DateTime.now(),
                                        firstDay: DateTime.utc(2010, 10, 16),
                                        lastDay: DateTime.utc(2030, 3, 14),
                                        selectedDayPredicate: (day) =>
                                            isSameDay(day, _selectedDay),
                                        calendarStyle: const CalendarStyle(
                                            outsideDaysVisible: false),
                                        onDaySelected:
                                            (selectedDay, focusedDay) {
                                          _onDaySelected(convenientDays,
                                              selectedDay, focusedDay);
                                        },
                                        enabledDayPredicate: (day) {
                                          bool isWeekend = _isWeekend(
                                              appointmentCalendar,
                                              convenientDays,
                                              day,
                                              DateTime.now());

                                          // Return true if the day is not in the appointment dates list and is not a weekend
                                          return !isWeekend;
                                        },
                                        // enabledDayPredicate: (day) =>
                                        //     !_isWeekendStudent(
                                        //   day,
                                        //   DateTime.now(),
                                        // ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'ช่วงเวลา',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text('ช่วงเวลาว่างของอาจารย์'),
                                          ],
                                        ),
                                        if (_selectedDay != null) ...[
                                          for (var convenient in convenientDays)
                                            if (convenient.day ==
                                                _selectedDay!.weekday)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                        'เวลา: ${convenient.timeStart}'),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Text(" - "),
                                                    ),
                                                    Text(
                                                        'เวลา: ${convenient.timeEnd}'),
                                                  ],
                                                ),
                                              ),
                                        ],
                                        if (matchingAppointments.isNotEmpty)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: matchingAppointments
                                                .map((appointment) {
                                              String startTime =
                                                  appointment.timeStart;
                                              String endTime =
                                                  appointment.timeEnd;

                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'นัดหมายอื่น:',
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    'เริ่ม: $startTime - สิ้นสุด: $endTime',
                                                  ),
                                                  SizedBox(height: 10),
                                                  Divider(),
                                                  SizedBox(height: 10),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              TimeOfDay? pickedTime =
                                                  await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    selectedStartTime ??
                                                        TimeOfDay.now(),
                                              );
                                              if (pickedTime != null) {
                                                setState(() {
                                                  selectedStartTime =
                                                      pickedTime;
                                                });
                                              }
                                            },
                                            child: InputDecorator(
                                              decoration: InputDecoration(
                                                labelText: 'เวลาเริ่ม',
                                              ),
                                              child: Text(
                                                selectedStartTime
                                                        ?.format(context) ??
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
                                                initialTime: selectedEndTime ??
                                                    TimeOfDay.now(),
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
                                                selectedEndTime
                                                        ?.format(context) ??
                                                    'เลือกเวลาจบ',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ห้อง',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FutureBuilder<UserModel>(
                        future: futureUser,
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (userSnapshot.hasError) {
                            return Center(
                                child: Text(
                                    'เกิดข้อผิดพลาด: ${userSnapshot.error}'));
                          } else if (!userSnapshot.hasData) {
                            return Center(child: Text('ไม่มีข้อมูล'));
                          } else {
                            final user = userSnapshot.data!;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 45,
                                  child: CheckboxListTile(
                                    value: _selectedRoomIndex == 1,
                                    onChanged: (value) {
                                      _roomCheckboxChanged(
                                          1, '${user.teacherRoom}');
                                    },
                                    title: Text('ห้องพักอาจารย์'),
                                  ),
                                ),
                                if (_selectedRoomIndex == 1)
                                  Container(
                                    child: Text(
                                      'สถานที่ : ${user.teacherRoom}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                              ],
                            );
                          }
                        }),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: _selectedRoomIndex == 2,
                        onChanged: (value) {
                          _roomCheckboxChanged(2, '${_RoomController}');
                        },
                        title: Text('อื่นๆ'),
                      ),
                    ),
                    if (_selectedRoomIndex == 2)
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color.fromARGB(255, 13, 187, 158),
                          ),
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
                                  return 'กรุณากรอกห้องที่สะดวก';
                                }
                                return null;
                              },
                              controller: _RoomController,
                              decoration: InputDecoration(
                                hintText: 'กรอกห้องที่สะดวก',
                                hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: GoogleFonts.prompt().fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'สถานะ',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: status == 0,
                        onChanged: (value) {
                          _statusCheckboxChanged(0);
                        },
                        title: Text('ปกติ'),
                      ),
                    ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: status == 1,
                        onChanged: (value) {
                          _statusCheckboxChanged(1);
                        },
                        title: Text('เร่งด่วน'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
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
                            if (_appointmentform.currentState!.validate()) {
                              if (!_validateTimeRange()) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.topSlide,
                                  showCloseIcon: true,
                                  title: "เวลาไม่ถูกต้อง",
                                  desc: "กรุณาเลือกเวลาเริ่มต้นก่อนเวลาเลิก.",
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
                                title: "ยืนยันการขอนัดหมาย?",
                                desc: "คุณต้องการขอนัดหมายใช่หรือไม่?",
                                btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                                  AppointmentInsertModel res =
                                      await fetchAppointmentInsert();
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.topSlide,
                                    showCloseIcon: true,
                                    title: "ขอนัดหมายสำเร็จ",
                                    btnOkOnPress: () {},
                                  ).show();
                                },
                              ).show();
                            }

                            print('user_id: ${widget.user_id}');
                            print('target_id: ${_selectedUser_id}');
                            if (_selectedTitleIndex == 1 ||
                                _selectedTitleIndex == 2) {
                              print('title: ${selectedTitleText}');
                            } else {
                              print('title: ${_otherTitleController.text}');
                            }
                            print(
                                'title_detail: ${_detailTitleController.text}');

// ฟังก์ชั่นเพื่อฟอร์แมตเวลา
                            String _formatTimeOfDay(TimeOfDay timeOfDay) {
                              // Convert TimeOfDay to DateTime
                              final now = DateTime.now();
                              final dateTime = DateTime(now.year, now.month,
                                  now.day, timeOfDay.hour, timeOfDay.minute);

                              // Format DateTime as hh:mm:ss A (12-hour clock with AM/PM)
                              final formatter = DateFormat('hh:mm:ss a');
                              return formatter.format(dateTime);
                            }

                            final startTime =
                                _formatTimeOfDay(selectedStartTime!);
                            final endTime = _formatTimeOfDay(selectedEndTime!);
                            print('startTime: ${startTime}');
                            print('endTime: ${endTime}');

                            if (_selectedRoomIndex == 1) {
                              print('room: ${selectedRoomText}');
                            } else {
                              print('room: ${_RoomController.text}');
                            }
                            print('priority_level: ${status}');
                          },
                          child: const Center(
                            child: Text(
                              "เพิ่มข้อมูลนัดหมาย",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _filterStudents(List<UserStudentModel> userStudents) {
    if (selectedCourse != null && selectedYear != null) {
      setState(() {
        filteredStudents = userStudents
            .where((student) =>
                student.courseId.toString() == selectedCourse &&
                student.studentId.startsWith(selectedYear!))
            .toList();
      });
    } else if (selectedCourse != null) {
      setState(() {
        filteredStudents = userStudents
            .where((student) => student.courseId.toString() == selectedCourse)
            .toList();
      });
    } else if (selectedYear != null) {
      setState(() {
        filteredStudents = userStudents
            .where((student) => student.studentId.startsWith(selectedYear!))
            .toList();
      });
    } else {
      setState(() {
        filteredStudents = userStudents;
      });
    }
  }
}

Widget _buildDropdown(
  String selectedValue,
  List<String> times,
  ValueChanged<String?> onChanged,
) {
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
          value: times.contains(selectedValue) ? selectedValue : null,
          icon: const Icon(Icons.arrow_drop_down, size: 30),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
              color: Colors.black, fontFamily: GoogleFonts.prompt().fontFamily),
          underline: Container(height: 0, color: Colors.transparent),
          onChanged: onChanged,
          items: times.isNotEmpty
              ? times.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text(value, style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                  );
                }).toList()
              : [
                  DropdownMenuItem<String>(
                    value: selectedValue,
                    child: Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(selectedValue,
                            style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                ],
        ),
      ),
    ),
  );
}
