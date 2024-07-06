import 'package:apppointment/Colors/app_color.dart';
import 'package:apppointment/api/appointments_api.dart';
import 'package:apppointment/api/user_api.dart';
import 'package:apppointment/page/message_wait.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:apppointment/page/message_confirm.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;
import 'package:intl/intl.dart';

class Message extends StatefulWidget {
  final int user_id;
  const Message(this.user_id, {Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  late Future<List<AppointmentModel>> futureAppointmentMe;
  late Future<List<AppointmentModel>> futureAppointmentAnother;

  @override
  void initState() {
    super.initState();
    futureAppointmentMe = fetchAppointmentMe(widget.user_id);
    futureAppointmentAnother = fetchAppointmentAnother(widget.user_id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Icon(
                EneftyIcons.message_2_bold,
                size: 30,
                color: AppColors.primaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "คำร้องขอนัดหมาย",
                style: GoogleFonts.kanit(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'คำขอนัดหมายของผู้อื่น'),
                Tab(text: 'คำขอนัดหมายของฉัน'),
              ],
            ),
            Expanded(
                child: TabBarView(
              children: [
                FutureBuilder<List<AppointmentModel>>(
                  future: futureAppointmentAnother,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('ไม่มีข้อมูล'));
                    } else {
                      return ListView.builder(
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.34,
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
                                                  fontSize: 14,
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
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
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
                                                height: 10,
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
                                                                text:
                                                                    "รอวันนัดหมาย",
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
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            0,
                                                                            98,
                                                                            209),
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
                                                              Message_Confirm(
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
                      );
                    }
                  },
                ),
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                FutureBuilder<List<AppointmentModel>>(
                  future: futureAppointmentMe,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('ไม่มีข้อมูล'));
                    } else {
                      return ListView.builder(
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.34,
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
                                                  fontSize: 14,
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
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
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
                                                height: 10,
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
                                                                text:
                                                                    "รอวันนัดหมาย",
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
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            0,
                                                                            98,
                                                                            209),
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
                                                              Message_Wait(
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
                      );
                    }
                  },
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.all(20.0),
                //       child: SizedBox(
                //           width: 300,
                //           child: Image.asset("assets/images/not_app.png")),
                //     ),
                //     const Text(
                //       "ไม่มีคำขอนัดหมาย",
                //       style:
                //           TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                //     ),
                //   ],
                // ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
