import 'package:apppointment/api/appointments_count_api.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final int user_id;
  final String prefix;
  final String firstName;
  final String lastName;

  const HomeScreen(this.user_id, this.prefix, this.firstName, this.lastName,
      {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<AppointmentCountModel> futureAppointmentModel_0;
  late Future<AppointmentCountModel> futureAppointmentModel_1;
  late Future<AppointmentCountModel> futureAppointmentModel_2;
  late Future<AppointmentCountModel> futureAppointmentModel_3;

  @override
  void initState() {
    futureAppointmentModel_0 = fetchAppointmentModelStatusCount(0);
    futureAppointmentModel_1 = fetchAppointmentModelStatusCount(1);
    futureAppointmentModel_2 = fetchAppointmentModelStatusCount(2);
    futureAppointmentModel_3 = fetchAppointmentModelStatusCount(3);
    super.initState();
  }

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "APPT CIS",
              style: GoogleFonts.kanit(
                  textStyle:
                      const TextStyle(fontSize: 18, color: Colors.black38)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Hi, ${widget.prefix} ${widget.firstName} ${widget.lastName}",
              style: GoogleFonts.kanit(
                  textStyle:
                      const TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                if (kDebugMode) {
                  print("notification");
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(
                  right: 15,
                ),
                child: Icon(
                  EneftyIcons.notification_outline,
                  size: 26,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: Future.wait([
                  futureAppointmentModel_0,
                  futureAppointmentModel_1,
                  futureAppointmentModel_2,
                  futureAppointmentModel_3,
                ]),
                builder: (context,
                    AsyncSnapshot<List<AppointmentCountModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data'));
                  } else if (snapshot.hasData) {
                    final counts = snapshot.data!;
                    final List<Map<String, dynamic>> appts = [
                      {
                        'title': 'รอยืนยันนัดหมาย',
                        'count': counts[0].count,
                        'icon': Icons.access_time,
                        'color': Colors.orange,
                      },
                      {
                        'title': 'รอวันนัดหมาย',
                        'count': counts[1].count,
                        'icon': Icons.event_note,
                        'color': Colors.blue,
                      },
                      {
                        'title': 'นัดหมายสำเร็จ',
                        'count': counts[2].count,
                        'icon': Icons.check_circle,
                        'color': Colors.green,
                      },
                      {
                        'title': 'ปฏิเสธนัดหมาย',
                        'count': counts[3].count,
                        'icon': Icons.cancel,
                        'color': Colors.red,
                      },
                    ];

                    final total = appts.fold<int>(
                        0, (sum, item) => sum + (item['count'] as int));

                    return Column(
                      children: [
                        GridView.builder(
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 4),
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: appts.length,
                          itemBuilder: (context, index) {
                            final appt = appts[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 238, 238, 238),
                                    offset: Offset(0, 0),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          appt["title"],
                                          style: GoogleFonts.kanit(
                                              textStyle: const TextStyle(
                                            color: Color.fromARGB(166, 0, 0, 0),
                                          )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          appt['icon'],
                                          size: 20,
                                          color: appt['color'],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      appt["count"].toString(),
                                      style: GoogleFonts.kanit(
                                          textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    EneftyIcons.chart_2_bold,
                                    color: Color.fromARGB(255, 0, 65, 163),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "รายงานจำนวนการนัดหมายทั้งหมด",
                                    style: GoogleFonts.kanit(
                                        textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 0, 65, 163),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    )),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.38,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 238, 238, 238),
                                        offset: Offset(0, 0),
                                        blurRadius: 10,
                                      )
                                    ],
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1.7,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: PieChart(
                                              PieChartData(
                                                pieTouchData: PieTouchData(
                                                  touchCallback:
                                                      (FlTouchEvent event,
                                                          pieTouchResponse) {
                                                    setState(() {
                                                      if (!event
                                                              .isInterestedForInteractions ||
                                                          pieTouchResponse ==
                                                              null ||
                                                          pieTouchResponse
                                                                  .touchedSection ==
                                                              null) {
                                                        touchedIndex = -1;
                                                        return;
                                                      }
                                                      touchedIndex =
                                                          pieTouchResponse
                                                              .touchedSection!
                                                              .touchedSectionIndex;
                                                    });
                                                  },
                                                ),
                                                borderData: FlBorderData(
                                                  show: false,
                                                ),
                                                sectionsSpace: 0,
                                                centerSpaceRadius: 40,
                                                sections: showingSections(
                                                    appts, total),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: appts.map((appt) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 100,
                                                      vertical: 2),
                                              child: Indicator(
                                                color: appt['color'],
                                                text: appt['title'],
                                                isSquare: true,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      List<Map<String, dynamic>> appts, int total) {
    return List.generate(appts.length, (i) {
      final appt = appts[i];
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 55.0;
      final percentage = ((appt['count'] / total) * 100).toStringAsFixed(1);
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: appt['color'],
        value: (appt['count'] / total) * 100,
        title: '$percentage%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
      );
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        )
      ],
    );
  }
}
