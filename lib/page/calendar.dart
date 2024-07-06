import 'package:apppointment/Colors/app_color.dart';
import 'package:apppointment/api/appointments_api.dart';
import 'package:apppointment/page/calendar_detail.dart';
import 'package:apppointment/page/calendar_detail_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:table_calendar/table_calendar.dart'; // ให้แน่ใจว่า import package นี้ถูกต้อง
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class CalendarScreen extends StatefulWidget {
  final int user_id;
  const CalendarScreen(this.user_id, {Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Future<List<AppointmentModel>> futureAppointmentWait;
  late DateTime today;
  late DateTime selectedFutureDay;
  Map<String, List<String>> _events = {};
  late final ValueNotifier<List<String>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    futureAppointmentWait = fetchAppointmentWait(widget.user_id);
    futureAppointmentWait.then((appointments) {
      setState(() {
        _events = _getEventsFromAppointments(appointments);
      });
    });
    today = DateTime.now();
    selectedFutureDay = today;
    _selectedEvents = ValueNotifier<List<String>>([]);
  }

  Map<String, List<String>> _getEventsFromAppointments(
      List<AppointmentModel> appointments) {
    Map<String, List<String>> events = {};
    for (var appointment in appointments) {
      DateTime date = DateTime.parse("${appointment.date}");
      String dateKey =
          DateFormat('yyyy-MM-dd').format(date); // แปลง DateTime เป็นสตริง
      if (events[dateKey] == null) {
        events[dateKey] = [];
      }
      events[dateKey]!.add(appointment.title);
    }
    return events;
  }

  List<String> _getEventsForDay(DateTime day) {
    String dateKey =
        DateFormat('yyyy-MM-dd').format(day); // แปลง DateTime เป็นสตริง
    return _events[dateKey] ?? [];
  }

  bool _isWeekend(DateTime day) {
    return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
    _selectedEvents.value = _getEventsForDay(day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(
              EneftyIcons.calendar_2_bold,
              size: 35,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "ปฏิทิน",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.blue,
                  // ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TableCalendar<String>(
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    rowHeight: 40,
                    availableGestures: AvailableGestures.all,
                    focusedDay: today,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    calendarStyle:
                        const CalendarStyle(outsideDaysVisible: false),
                    eventLoader: _getEventsForDay,
                    onDaySelected: _onDaySelected,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "ข้อมูลการนัดหมาย",
                  style: GoogleFonts.kanit(
                      textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
                ),
              ),
              FutureBuilder<List<AppointmentModel>>(
                future: futureAppointmentWait,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('ไม่มีข้อมูล'));
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
                                                              fontSize: 16,
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
                                                      if (appointment.userId ==
                                                          widget.user_id)
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                CalendarDetail(
                                                                    appointment
                                                                        .appointmentId),
                                                          ),
                                                        );
                                                      if (appointment
                                                              .targetId ==
                                                          widget.user_id)
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                CalendarDetail_2(
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
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
