import 'package:apppointment/api/appointment_all_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;
import 'package:intl/intl.dart';

class CalendarDetail_2 extends StatefulWidget {
  final int appointmentId;
  const CalendarDetail_2(this.appointmentId, {Key? key}) : super(key: key);

  @override
  State<CalendarDetail_2> createState() => _CalendarDetail_2State();
}

class _CalendarDetail_2State extends State<CalendarDetail_2> {
  late Future<AppointmentAllModel> futureAppointmentAllAnother;

  @override
  void initState() {
    super.initState();
    futureAppointmentAllAnother =
        fetchAppointmentAllAnother(widget.appointmentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียด'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<AppointmentAllModel>(
          future: futureAppointmentAllAnother,
          builder: (context, Snapshot) {
            if (Snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (Snapshot.hasError) {
              return Center(child: Text('เกิดข้อผิดพลาด: ${Snapshot.error}'));
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
              String formattedTime_end = DateFormat('HH.mm').format(time_end);
              return Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // border: Border.all(
                          //   color: Colors.black,
                          //   width: 2.0,
                          // ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Center(
                                    child: Text(
                                      'รอวันนัดหมาย',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        child: Image.network(
                                          imageUrl,
                                          height: 130,
                                          headers: {
                                            'Authorization':
                                                'Bearer ' + globals.jwtToken,
                                          },
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      Text(
                                        '',
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
                                        'สถานที่   :  ${appointment.location}',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(),
                                  Row(
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
                                          color: appointment.priorityLevel == 0
                                              ? Colors.black
                                              : appointment.priorityLevel == 1
                                                  ? Colors.blue
                                                  : Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 5,
                                  ),
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
                                  // if (appointment.notApprovedDetail != null)
                                  //   Row(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         'เหตุผลที่แก้ไข:',
                                  //         style: TextStyle(
                                  //           fontSize: 16,
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       ),
                                  //       Container(
                                  //         width: 220,
                                  //         child: Text(
                                  //           ' ${appointment.notApprovedDetail}',
                                  //           style: TextStyle(
                                  //             fontSize: 16,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // if (appointment.notApprovedDetail != null)
                                  //   Divider(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
