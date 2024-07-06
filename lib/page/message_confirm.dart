import 'dart:convert';

import 'package:apppointment/api/appointment_all_api.dart';
import 'package:apppointment/api/appointment_confirm_api.dart';
import 'package:apppointment/page/dialog_reject_appointment.dart';
import 'package:apppointment/page/message_confirm_edit.dart';
import 'package:apppointment/page/message_wait_edit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;
import 'package:intl/intl.dart';

class Message_Confirm extends StatefulWidget {
  final int appointmentId;
  const Message_Confirm(this.appointmentId, {Key? key}) : super(key: key);

  @override
  State<Message_Confirm> createState() => _Message_ConfirmState();
}

class _Message_ConfirmState extends State<Message_Confirm> {
  late Future<AppointmentAllModel> futureAppointmentAllAnother;
  final _confirmAppointment = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    futureAppointmentAllAnother =
        fetchAppointmentAllAnother(widget.appointmentId);
  }

  Future<AppointmentConfirmModel> ConfirmAppointment() async {
    final appointment_id = widget.appointmentId;

    final url =
        Uri.parse('https://appt-cis.smt-online.com/api/appointment/comfirm');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + globals.jwtToken
    };

    final body = jsonEncode(
      {
        'id': appointment_id,
      },
    );

    final response = await http.post(url, headers: headers, body: body);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final appointmentRejectModel =
          AppointmentConfirmModel.fromJson(json.decode(response.body));
      print('Appointment Reject Model: $appointmentRejectModel');
      return appointmentRejectModel;
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: "นัดหมายไม่สำเร็จ",
        btnOkOnPress: () {},
      ).show();
      print(
          'Failed to Reject appointment. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to Reject appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'รายละเอียดการนัดหมาย',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _confirmAppointment,
          child: FutureBuilder<AppointmentAllModel>(
              future: futureAppointmentAllAnother,
              builder: (context, Snapshot) {
                if (Snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (Snapshot.hasError) {
                  return Center(
                      child: Text('เกิดข้อผิดพลาด: ${Snapshot.error}'));
                } else if (!Snapshot.hasData) {
                  return Center(child: Text('ไม่มีข้อมูล'));
                } else {
                  final appointment = Snapshot.data!;
                  final String imageUrl =
                      'https://appt-cis.smt-online.com/api/public/${appointment.imageProfile}';
                  DateTime date = DateTime.parse('${appointment.date}');
                  String formattedDate = DateFormat('dd-MM-yyyy').format(date);
                  DateTime time_start =
                      DateTime.parse('1970-01-01 ${appointment.timeStart}');
                  String formattedTime_start =
                      DateFormat('HH.mm').format(time_start);
                  DateTime time_end =
                      DateTime.parse('1970-01-01 ${appointment.timeEnd}');
                  String formattedTime_end =
                      DateFormat('HH.mm').format(time_end);
                  return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 3.0,
                                  blurRadius: 5.0,
                                  offset: const Offset(
                                      0.0, 1.0), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Center(
                                        child: Text(
                                          'รอยืนยันนัดหมาย',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            child: Image.network(
                                              imageUrl,
                                              height: 130,
                                              headers: {
                                                'Authorization': 'Bearer ' +
                                                    globals.jwtToken,
                                              },
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${appointment.prefix} ${appointment.firstName} ${appointment.lastName}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          appointment.roleUser == 0
                                              ? Text(
                                                  'หลักสูตรสาขาวิชา${appointment.courseName}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                )
                                              : SizedBox(),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.date_range),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'วันที่      :  ${formattedDate}',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_sharp,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'เวลา      :  ${formattedTime_start}-${formattedTime_end} น.',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.business),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'สถานที่   :  ',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: Text(
                                              '${appointment.location}',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Divider(),
                                      const Row(
                                        children: [
                                          Text(
                                            'เรื่อง: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${appointment.title}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Divider(),
                                      const Row(
                                        children: [
                                          Text(
                                            'รายละเอียด:',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: 320,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${appointment.titleDetail}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'ระดับความสำคัญ: ',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            appointment.priorityLevel == 0
                                                ? 'ปกติ'
                                                : appointment.priorityLevel == 1
                                                    ? 'เร่งด่วน'
                                                    : '',
                                            style: TextStyle(
                                              color: appointment
                                                          .priorityLevel ==
                                                      0
                                                  ? Colors.black
                                                  : appointment.priorityLevel ==
                                                          1
                                                      ? Colors.blue
                                                      : Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          const Text(
                                            'ช่องทางการติดต่อ:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'อีเมล:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ' : ${appointment.email}',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (appointment.line != null)
                                        Row(
                                          children: [
                                            Text(
                                              'ไอดีไลน์:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              ' ${appointment.line}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (appointment.phoneNumber != null)
                                        Row(
                                          children: [
                                            Text(
                                              'เบอร์โทรศัพท์:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              ' ${appointment.phoneNumber}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (appointment.facebook != null)
                                        Row(
                                          children: [
                                            Text(
                                              'ชื่อเฟซบุ๊ก:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              ' ${appointment.facebook}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      Divider(),
                                      if (appointment.notApprovedDetail != null)
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'เหตุผลที่แก้ไข:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              width: 220,
                                              child: Text(
                                                ' ${appointment.notApprovedDetail}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (appointment.notApprovedDetail != null)
                                        Divider(),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        'ต้องการนัดหมายหรือไม่ ?',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Container(
                                        width: 300,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              255, 13, 187, 158),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.question,
                                              animType: AnimType.topSlide,
                                              showCloseIcon: true,
                                              title: "ยืนยันการนัดหมาย?",
                                              desc:
                                                  "คุณต้องการนัดหมายใช่หรือไม่?",
                                              btnCancelOnPress: () {},
                                              btnOkOnPress: () async {
                                                if (_confirmAppointment
                                                    .currentState!
                                                    .validate()) {}
                                                AppointmentConfirmModel res =
                                                    await ConfirmAppointment();
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType:
                                                      DialogType.success,
                                                  animType: AnimType.topSlide,
                                                  showCloseIcon: true,
                                                  title: "นัดหมายสำเร็จ",
                                                  btnOkOnPress: () {},
                                                ).show();
                                              },
                                            ).show();
                                          },
                                          child: const Center(
                                            child: Text(
                                              "ยืนยันนัดหมาย",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Center(
                                      child: Container(
                                        width: 300,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blue,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Message_Confirm_Edit(
                                                  appointment.appointmentId,
                                                  appointment.title,
                                                  appointment.titleDetail,
                                                  appointment.timeStart,
                                                  appointment.timeEnd,
                                                  appointment.location,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Center(
                                            child: Text(
                                              "แก้ไขนัดหมาย",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Center(
                                      child: Container(
                                        width: 300,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    Dialog_Reject_Appointment(
                                                        appointment
                                                            .appointmentId));
                                          },
                                          child: const Center(
                                            child: Text(
                                              "ปฏิเสธนัดหมาย",
                                              style: TextStyle(
                                                  fontSize: 16,
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
