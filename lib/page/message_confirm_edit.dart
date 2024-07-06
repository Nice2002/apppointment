import 'dart:convert';

import 'package:apppointment/api/appointment_update_api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;
import 'package:intl/intl.dart';

class Message_Confirm_Edit extends StatefulWidget {
  final int appointmentId;
  final String title;
  final String titleDetail;
  final String timeStart;
  final String timeEnd;
  final String location;

  const Message_Confirm_Edit(this.appointmentId, this.title, this.titleDetail,
      this.timeStart, this.timeEnd, this.location,
      {Key? key})
      : super(key: key);

  @override
  State<Message_Confirm_Edit> createState() => _Message_Confirm_EditState();
}

class _Message_Confirm_EditState extends State<Message_Confirm_Edit> {
  final _updateAppointment = GlobalKey<FormState>();
  final roomController = TextEditingController();
  final notApprovedController = TextEditingController();

  List<String> _startTimes = [
    '08:00:00',
    '09:00:00',
    '10:00:00',
    '11:00:00',
    '12:00:00',
    '13:00:00',
    '14:00:00'
  ];
  List<String> _endTimes = [
    '08:00:00',
    '09:00:00',
    '10:00:00',
    '11:00:00',
    '12:00:00',
    '13:00:00',
    '14:00:00'
  ];

  String? strattime;
  String? endtime;

  @override
  void initState() {
    super.initState();

    roomController.text = widget.location;

    // _startTimes = [widget.timeStart ?? '08:00'];
    // _endTimes = [widget.timeEnd ?? '12:00'];

    strattime = widget.timeStart;
    endtime = widget.timeEnd;
  }

  Future<AppointmentUpdateModel> UpdateAppointment() async {
    final appointment_id = widget.appointmentId;
    final location = roomController.text;
    final notApproved = notApprovedController.text;

    String strattimeString = "2024-05-21 $strattime";
    String endtimeString = "2024-05-21 $endtime";

    DateTime strattimes = DateTime.parse(strattimeString);
    DateTime endtimes = DateTime.parse(endtimeString);

    final time_start =
        DateFormat('HH:mm:ss').format(strattimes); // Use 24-hour format
    final time_end =
        DateFormat('HH:mm:ss').format(endtimes); // Use 24-hour format

    final url =
        Uri.parse('https://appt-cis.smt-online.com/api/appointment/update_2');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + globals.jwtToken
    };

    print(appointment_id);
    print(location);
    print(notApproved);
    print(time_start);
    print(time_end);

    final body = jsonEncode(
      {
        'id': appointment_id,
        'location': location,
        'notApprovedDetail': notApproved,
        'appointments': [
          {
            'time_start': time_start,
            'time_end': time_end,
          }
        ],
      },
    );

    final response = await http.post(url, headers: headers, body: body);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final appointmentUpdateModel =
          AppointmentUpdateModel.fromJson(json.decode(response.body));
      print('Appointment Update Model: $appointmentUpdateModel');
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
      print(
          'Failed to Update appointment. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('ช่วงเวลา', style: TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDropdown(
                      strattime ?? 'เลือกเวลาเริ่ม',
                      _startTimes,
                      (newValue) {
                        setState(() {
                          strattime = newValue;
                        });
                      },
                    ),
                    Text('ถึง', style: TextStyle(fontSize: 16)),
                    _buildDropdown(
                      endtime ?? 'เลือกเวลาจบ',
                      _endTimes,
                      (newValue) {
                        setState(() {
                          endtime = newValue;
                        });
                      },
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
                    border: Border.all(color: Colors.black.withOpacity(0.5)),
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
                            fontFamily: GoogleFonts.prompt().fontFamily,
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
                    border: Border.all(color: Colors.black.withOpacity(0.5)),
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
                            fontFamily: GoogleFonts.prompt().fontFamily,
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
                    width: 375,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 13, 187, 158),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (_updateAppointment.currentState!.validate()) {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.question,
                              animType: AnimType.topSlide,
                              showCloseIcon: true,
                              title: "ยืนยันการแก้ไข?",
                              desc: "คุณต้องการแก้ไขนัดหมายใช่หรือไม่?",
                              btnCancelOnPress: () {},
                              btnOkOnPress: () async {
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
                              }).show();
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
