import 'package:apppointment/widget/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DonutProfile extends StatefulWidget {
  const DonutProfile({super.key});

  @override
  State<DonutProfile> createState() => _DonutProfileState();
}

class _DonutProfileState extends State<DonutProfile> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Container(
            child: Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    sectionsSpace: 5,
                    centerSpaceRadius: 50,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 100),
            child: Column(
              children: <Widget>[
                Indicator(
                  color: Colors.green,
                  text: 'จำนวนครั้งนัดหมาย 5 ครั้ง',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.blue,
                  text: 'จำนวนครั้งรอนัดหมาย 4 ครั้ง',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.red,
                  text: 'จำนวนครั้งปฏิเสธ 3 ครั้ง',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                // Indicator(
                //   color: Colors.green,
                //   text: 'Fourth',
                //   isSquare: true,
                // ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: 35,
            title: '35%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: 25,
            title: '25%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        // case 3:
        //   return PieChartSectionData(
        //     color: Colors.green,
        //     value: 10,
        //     title: '10%',
        //     radius: radius,
        //     titleStyle: TextStyle(
        //       fontSize: fontSize,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white,
        //       shadows: shadows,
        //     ),
        //   );
        default:
          throw Error();
      }
    });
  }
}
