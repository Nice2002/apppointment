import 'package:apppointment/api/appointments_api.dart';
import 'package:apppointment/api/appointments_count_api.dart';
import 'package:apppointment/page/history_detail.dart';
import 'package:apppointment/widget/donut_profile.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;
import 'package:intl/intl.dart';

class Histroy extends StatefulWidget {
  final int user_id;
  const Histroy(this.user_id, {Key? key}) : super(key: key);

  @override
  State<Histroy> createState() => _HistroyState();
}

class _HistroyState extends State<Histroy> {
  late Future<List<AppointmentModel>> futureAppointmentStatus;
  late Future<AppointmentCountModel> futureAppointmentModel_0;
  late Future<AppointmentCountModel> futureAppointmentModel_1;
  late Future<AppointmentCountModel> futureAppointmentModel_2;
  late Future<AppointmentCountModel> futureAppointmentModel_3;

  @override
  void initState() {
    super.initState();
    futureAppointmentStatus = fetchAppointmentStatus(widget.user_id);
    futureAppointmentModel_0 =
        fetchAppointmentModelStatusCountUser(0, widget.user_id);
    futureAppointmentModel_1 =
        fetchAppointmentModelStatusCountUser(1, widget.user_id);
    futureAppointmentModel_2 =
        fetchAppointmentModelStatusCountUser(2, widget.user_id);
    futureAppointmentModel_3 =
        fetchAppointmentModelStatusCountUser(3, widget.user_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประวัติการนัดหมาย'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 238, 238, 238),
                      offset: Offset(0, 0),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: FutureBuilder<List<AppointmentCountModel>>(
                  future: Future.wait([
                    futureAppointmentModel_0,
                    futureAppointmentModel_1,
                    futureAppointmentModel_2,
                    futureAppointmentModel_3,
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                    } else {
                      List<AppointmentCountModel> appointmentModels =
                          snapshot.data!;

                      print(appointmentModels[0].count);
                      print(appointmentModels[1].count);
                      print(appointmentModels[2].count);
                      print(appointmentModels[3].count);

                      return DonutProfile(
                        appointmentModels[0].count,
                        appointmentModels[1].count,
                        appointmentModels[2].count,
                        appointmentModels[3].count,
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder<List<AppointmentModel>>(
                future: futureAppointmentStatus,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('ไม่มีข้อมูล');
                  } else {
                    return SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final appointment = snapshot.data![index];
                          final String imageUrl =
                              'https://appt-cis.smt-online.com/api/public/${appointment.imageProfile}';
                          DateTime date = DateTime.parse('${appointment.date}');
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(date);
                          DateTime time_start = DateTime.parse(
                              '1970-01-01 ${appointment.timeStart}');
                          String formattedTime_start =
                              DateFormat('HH.mm').format(time_start);
                          DateTime time_end = DateTime.parse(
                              '1970-01-01 ${appointment.timeEnd}');
                          String formattedTime_end =
                              DateFormat('HH.mm').format(time_end);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.32,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "วันเวลานัดหมาย",
                                          style: GoogleFonts.kanit(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              EneftyIcons.calendar_2_outline,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "$formattedDate",
                                              style: GoogleFonts.kanit(
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                            ),
                                            const Icon(
                                              EneftyIcons.timer_2_outline,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "$formattedTime_start - $formattedTime_end น.",
                                              style: GoogleFonts.kanit(
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Divider(),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.21,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Image.network(
                                                        imageUrl,
                                                        headers: {
                                                          'Authorization':
                                                              'Bearer ' +
                                                                  globals
                                                                      .jwtToken,
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: Text(
                                                          "${appointment.prefix} ${appointment.firstName} ${appointment.lastName}",
                                                          style:
                                                              GoogleFonts.kanit(
                                                            textStyle:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      0,
                                                                      98,
                                                                      209),
                                                            ),
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: Text.rich(
                                                          TextSpan(
                                                            text: "เรื่อง: ",
                                                            style: GoogleFonts
                                                                .kanit(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                text:
                                                                    "${appointment.title}",
                                                                style:
                                                                    GoogleFonts
                                                                        .kanit(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: Text.rich(
                                                          TextSpan(
                                                            text: "สถานะ: ",
                                                            style: GoogleFonts
                                                                .kanit(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                text: appointment
                                                                            .status ==
                                                                        2
                                                                    ? 'นัดหมายสำเร็จ'
                                                                    : appointment.status ==
                                                                            3
                                                                        ? 'นัดหมายถูกปฏิเสธ'
                                                                        : '',
                                                                style:
                                                                    GoogleFonts
                                                                        .kanit(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: appointment.status ==
                                                                            2
                                                                        ? Colors
                                                                            .green
                                                                        : appointment.status ==
                                                                                3
                                                                            ? Colors.red
                                                                            : Colors.black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: Text.rich(
                                                          TextSpan(
                                                            text:
                                                                "ระดับความสำคัญ: ",
                                                            style: GoogleFonts
                                                                .kanit(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                text: appointment
                                                                            .priorityLevel ==
                                                                        0
                                                                    ? 'ปกติ'
                                                                    : appointment.priorityLevel ==
                                                                            1
                                                                        ? 'เร่งด่วน'
                                                                        : '',
                                                                style:
                                                                    GoogleFonts
                                                                        .kanit(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    color: appointment.priorityLevel ==
                                                                            0
                                                                        ? Colors
                                                                            .black
                                                                        : appointment.priorityLevel ==
                                                                                1
                                                                            ? Colors.blue
                                                                            : Colors.black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.85,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              HistoryDetail(
                                                                  appointment
                                                                      .appointmentId),
                                                        ),
                                                      );
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        "ดูรายละเอียดเพิ่มเติม",
                                                        style: GoogleFonts.kanit(
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getStatusColor(int index) {
    switch (index) {
      case 0:
        return const Color.fromARGB(
            255, 13, 187, 158); // Your color for index 0
      case 1:
        return Colors.red; // Your color for index 1
      case 2:
        return Colors.red; // Your color for index 2
      // Add more cases as needed
      default:
        return Colors.black; // Default color
    }
  }
}
