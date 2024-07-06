import 'package:apppointment/api/appointments_api.dart';
import 'package:apppointment/page/calendar_detail.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;
import 'package:intl/intl.dart';

class Calendarpage extends StatefulWidget implements PreferredSizeWidget {
  final int user_id;
  const Calendarpage(this.user_id, {Key? key}) : super(key: key);

  @override
  State<Calendarpage> createState() => _CalendarpageState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CalendarpageState extends State<Calendarpage> {
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

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
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
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 3,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(
              Icons.calendar_month,
              size: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "ปฏิทิน",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: TableCalendar<String>(
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  rowHeight: 45,
                  availableGestures: AvailableGestures.all,
                  focusedDay: today,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  calendarStyle: const CalendarStyle(outsideDaysVisible: false),
                  eventLoader: _getEventsForDay,
                  onDaySelected: _onDaySelected,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Divider(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ข้อมูลการนัดหมาย",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 5),
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
                        DateTime time_end =
                            DateTime.parse('1970-01-01 ${appointment.timeEnd}');
                        String formattedTime_end =
                            DateFormat('HH.mm').format(time_end);

                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2.0,
                                  blurRadius: 8.0,
                                  offset: const Offset(0.0, 1.0),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color.fromARGB(
                                                  255, 238, 237, 237),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                imageUrl,
                                                headers: {
                                                  'Authorization': 'Bearer ' +
                                                      globals.jwtToken,
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          SizedBox(
                                            width: 230,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${appointment.prefix} ${appointment.firstName} ${appointment.lastName}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  "วันที่: $formattedDate",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  "เวลา: $formattedTime_start - $formattedTime_end น.",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  "เรื่อง: ${appointment.title}",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "สถานะ: ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                "รอวันนัดหมาย",
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'ระดับความสำคัญ: ',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              Text(
                                                appointment.priorityLevel == 0
                                                    ? 'ปกติ'
                                                    : appointment
                                                                .priorityLevel ==
                                                            1
                                                        ? 'เร่งด่วน'
                                                        : '',
                                                style: TextStyle(
                                                  color: appointment
                                                              .priorityLevel ==
                                                          0
                                                      ? Colors.black
                                                      : appointment
                                                                  .priorityLevel ==
                                                              1
                                                          ? Colors.blue
                                                          : Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 35,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 13, 187, 158),
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CalendarDetail(appointment
                                                        .appointmentId),
                                              ),
                                            );
                                          },
                                          child: const Center(
                                            child: Text(
                                              "ข้อมูลเพิ่มเติม",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 13, 187, 158),
                                              ),
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
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getThaiMonthName(int month) {
    switch (month) {
      case 1:
        return 'มกราคม';
      case 2:
        return 'กุมภาพันธ์';
      case 3:
        return 'มีนาคม';
      case 4:
        return 'เมษายน';
      case 5:
        return 'พฤษภาคม';
      case 6:
        return 'มิถุนายน';
      case 7:
        return 'กรกฎาคม';
      case 8:
        return 'สิงหาคม';
      case 9:
        return 'กันยายน';
      case 10:
        return 'ตุลาคม';
      case 11:
        return 'พฤศจิกายน';
      case 12:
        return 'ธันวาคม';
      default:
        return '';
    }
  }
}
