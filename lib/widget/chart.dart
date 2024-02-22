import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <SplineSeries<SalesData, String>>[
          SplineSeries<SalesData, String>(
            dataSource: <SalesData>[
              SalesData(5, 'mon'),
              SalesData(15, 'Tue'),
              SalesData(20, 'Wen'),
              SalesData(22, 'Sat'),
              SalesData(25, 'sun'),
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          )
        ],
        plotAreaBackgroundColor: Color.fromARGB(255, 227, 252, 240),
        // backgroundColor: Color.fromARGB(255, 255, 246, 246),
        // borderColor: Colors.grey,
        borderWidth: 2,
      ),
    );
  }
}

class SalesData {
  SalesData(this.sales, this.year);
  final String year;
  final int sales;
}
