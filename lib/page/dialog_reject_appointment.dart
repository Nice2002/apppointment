import 'dart:convert';

import 'package:apppointment/api/appointment_reject_api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class Dialog_Reject_Appointment extends StatefulWidget {
  final int appointmentId;
  Dialog_Reject_Appointment(this.appointmentId, {Key? key}) : super(key: key);

  @override
  State<Dialog_Reject_Appointment> createState() =>
      _Dialog_Reject_AppointmentState();
}

class _Dialog_Reject_AppointmentState extends State<Dialog_Reject_Appointment> {
  final _rejectAppointment = GlobalKey<FormState>();
  final _notApproevdController = TextEditingController();

  Future<AppointmentRejectModel> RejectAppointment() async {
    final appointment_id = widget.appointmentId;
    final notApproved = _notApproevdController.text;

    final url =
        Uri.parse('https://appt-cis.smt-online.com/api/appointment/reject');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + globals.jwtToken
    };

    print(notApproved);

    final body = jsonEncode(
      {
        'id': appointment_id,
        'notApprovedDetail': notApproved,
      },
    );

    final response = await http.post(url, headers: headers, body: body);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final appointmentRejectModel =
          AppointmentRejectModel.fromJson(json.decode(response.body));
      print('Appointment Reject Model: $appointmentRejectModel');
      return appointmentRejectModel;
    } else {
      print(
          'Failed to Reject appointment. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to Reject appointment');
    }
  }

  @override
  void dispose() {
    _notApproevdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _rejectAppointment,
        child: Container(
          height: 300,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'เหตุผลที่ปฏิเสธ',
                style: TextStyle(
                  fontSize: 18,
                  // color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 150,
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
                          return 'กรุณากรอกเหตุผลที่ปฏิเสธ';
                        }
                        return null;
                      },
                      controller: _notApproevdController,
                      maxLines: 4,
                      maxLength: 100,
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
                      decoration: InputDecoration(
                        hintText: 'กรอกเหตุผลที่ปฏิเสธ',
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontFamily: GoogleFonts.prompt().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  'ต้องการปฏิเสธนัดหมายหรือไม่ ?',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 125,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 13, 187, 158),
                    ),
                    child: InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: const Center(
                        child: Text(
                          "ยกเลิก",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 125,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 13, 187, 158),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (_rejectAppointment.currentState!.validate()) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.topSlide,
                            showCloseIcon: true,
                            title: "ยืนยันปฏิเสธการนัดหมาย?",
                            desc: "คุณต้องการปฏิเสธนัดหมายใช่หรือไม่?",
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              AppointmentRejectModel res =
                                  await RejectAppointment();
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.topSlide,
                                showCloseIcon: true,
                                title: "ปฏิเสธนัดหมายสำเร็จ",
                                btnOkOnPress: () {},
                              ).show();
                            },
                          ).show();
                        }
                      },
                      child: const Center(
                        child: Text(
                          "ยืนยัน",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
