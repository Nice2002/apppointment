import 'package:apppointment/page/calendar_detail.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendarpage extends StatefulWidget implements PreferredSizeWidget {
  const Calendarpage({Key? key}) : super(key: key);

  @override
  State<Calendarpage> createState() => _CalendarpageState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CalendarpageState extends State<Calendarpage> {
  DateTime today = DateTime.now();
  Map<DateTime, List<String>> _events = {};
  late final ValueNotifier<List<String>> _selectedEvents;
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  // void initState() {
  //   super.initState();
  //   _selectedEvents = ValueNotifier<List<String>>([]);
  // }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  // List<String> _getEventsForRange(DateTime start, DateTime end) {
  //   final days = daysInRange(start, end);
  //   return [
  //     for (final d in days) ..._getEventsForDay(d),
  //   ];
  // }

  // List<DateTime> daysInRange(DateTime start, DateTime end) {
  //   final List<DateTime> days = [];

  //   for (int i = 0; i <= end.difference(start).inDays; i++) {
  //     days.add(start.add(Duration(days: i)));
  //   }

  //   return days;
  // }

  @override
  Widget build(BuildContext context) {
    _events = {
      DateTime.utc(2024, 1, 15): [
        'โครงงาน',
        'Homeroom ภาควิชา',
        'นัดหมายพูดคุยรายละเอียดโครงงาน'
      ],
      // DateTime.utc(2024, 1, 16): ['นัดหมายพูดคุยรายละเอียดโครงงาน'],
    };

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
              child: Divider(
                color: const Color.fromARGB(255, 13, 187, 158),
              ),
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
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final date = _events.keys.elementAt(index);
                final appointments = _events[date]!;
                return buildAppointmentCard(date, appointments);
              },
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppointmentCard(DateTime date, List<String> appointments) {
    List<String> teacher = [
      "อาจารย์อัจฉรา นามบุรี",
      "อาจารย์จารุวัฒน์ ไพลไหล",
      "อาจารย์จักรนรินทร์ คงเจริญ",
    ];
    String status = "รอนัดหมาย";
    List<String> date = [
      "16 มกราคม 2567",
      "20 กุมภาพันธ์ 2567",
      "3 มีนาคม 2567",
    ];
    List<String> timestart = [
      "9.00",
      "15.00",
      "7.30",
    ];
    List<String> timeend = [
      "12.00",
      "16.00",
      "10.30",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (final appointment in appointments) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/teacher.png",
                                width: 70,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    teacher[appointments.indexOf(appointment)],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "วันที่: ${date[appointments.indexOf(appointment)]}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "เวลา: ${timestart[appointments.indexOf(appointment)]} - ${timeend[appointments.indexOf(appointment)]} น.",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "เรื่อง: $appointment",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Color.fromARGB(255, 13, 187, 158),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "สถานะ ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "$status",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 206, 158, 0),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 35,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color.fromARGB(255, 13, 187, 158),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CalendarDetail(),
                                  ),
                                );
                              },
                              child: const Center(
                                child: Text(
                                  "ข้อมูลเพิ่มเติม",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 13, 187, 158),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // Widget buildSingleAppointmentCard(String appointment) {
  //   List<String> teacher = [
  //     "อาจารย์อัจฉรา นามบุรี",
  //     "อาจารย์จักรนรินทร์ คงเจริญ",
  //     "อาจารย์จารุวัฒน์ ไพลไหล"
  //   ];
  //   String status = "รอนัดหมาย";
  //   String topic = appointment;

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 10),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.1),
  //             spreadRadius: 2.0,
  //             blurRadius: 8.0,
  //             offset: const Offset(0.0, 1.0),
  //           ),
  //         ],
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(15.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Image.asset(
  //                       "assets/images/teacher.png",
  //                       height: 60,
  //                       width: 60,
  //                     ),
  //                     const SizedBox(
  //                       width: 15,
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           teacher[1],
  //                           style: const TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         const SizedBox(height: 2),
  //                         const Text(
  //                           "16 มกราคม 2567 | 10.30-11.20 น.",
  //                           style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 14,
  //                           ),
  //                         ),
  //                         const SizedBox(height: 2),
  //                         SizedBox(
  //                           width: 200,
  //                           child: Text(
  //                             "เรื่อง: $topic",
  //                             style: const TextStyle(
  //                               color: Colors.black,
  //                               fontSize: 16,
  //                             ),
  //                           ),
  //                         ),
  //                         const SizedBox(height: 2),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 5),
  //             const Divider(
  //               color: Color.fromARGB(255, 13, 187, 158),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     const Text(
  //                       "สถานะ ",
  //                       style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                     Text(
  //                       "$status",
  //                       style: const TextStyle(
  //                         color: Color.fromARGB(255, 206, 158, 0),
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Container(
  //                   height: 35,
  //                   width: 110,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     border: Border.all(
  //                       color: const Color.fromARGB(255, 13, 187, 158),
  //                     ),
  //                   ),
  //                   child: InkWell(
  //                     onTap: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => const CalendarDetail(),
  //                         ),
  //                       );
  //                     },
  //                     child: const Center(
  //                       child: Text(
  //                         "ข้อมูลเพิ่มเติม",
  //                         style: TextStyle(
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.bold,
  //                           color: Color.fromARGB(255, 13, 187, 158),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
