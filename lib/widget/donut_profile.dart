import 'package:apppointment/widget/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DonutProfile extends StatefulWidget {
  final count0;
  final count1;
  final count2;
  final count3;

  const DonutProfile(this.count0, this.count1, this.count2, this.count3,
      {Key? key})
      : super(key: key);

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
            height: 20,
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
                    sections: showingSections(
                        widget.count0 ?? 0,
                        widget.count1 ?? 0,
                        widget.count2 ?? 0,
                        widget.count3 ?? 0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, top: 30),
            child: Column(
              children: <Widget>[
                Indicator(
                  color: Colors.orange,
                  text: 'จำนวนครั้งรอยืนยันนัดหมาย ${widget.count0} ครั้ง',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.blue,
                  text: 'จำนวนครั้งรอวันนัดหมาย ${widget.count1} ครั้ง',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.green,
                  text: 'จำนวนครั้งนัดหมายสำเร็จ ${widget.count2} ครั้ง',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.red,
                  text: 'จำนวนครั้งนัดหมายถูกปฏิเสธ ${widget.count3} ครั้ง',
                  isSquare: true,
                ),
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

  List<PieChartSectionData> showingSections(
      int count0, int count1, int count2, int count3) {
    void calculatePercentage(List<int> values) {
      // หาผลรวมของค่าทั้งหมด
      int total = values.reduce((sum, value) => sum + value);

      // คำนวณเปอร์เซ็นต์และแสดงผล
      for (int i = 0; i < values.length; i++) {
        double percentage = (values[i] / total) * 100;
        print('ค่าที่ ${i + 1} คิดเป็น $percentage% ของผลรวมทั้งหมด');
      }
    }

    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.orange,
              value: count0.toDouble(),
              title:
                  '${((count0 / (count0 + count1 + count2 + count3)) * 100).toStringAsFixed(1)}%',
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
              color: Colors.blue,
              value: count1.toDouble(), // ใช้ค่า count1 ในการกำหนดค่า
              title:
                  '${((count1 / (count0 + count1 + count2 + count3)) * 100).toStringAsFixed(1)}%', // คำนวณและแสดงเปอร์เซ็นต์
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
              value: count2.toDouble(),
              title:
                  '${((count2 / (count0 + count1 + count2 + count3)) * 100).toStringAsFixed(1)}%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
            );

          case 3:
            return PieChartSectionData(
              color: Colors.red,
              value: count3.toDouble(),
              title:
                  '${((count3 / (count0 + count1 + count2 + count3)) * 100).toStringAsFixed(1)}%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
            );
          default:
            throw Error();
        }
      },
    );
  }
}
