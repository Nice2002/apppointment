import 'dart:math';

import 'package:flutter/material.dart';

class Dount extends StatefulWidget {
  Dount({super.key});
  final List<DataItem> dataset = [
    DataItem(0.2, "A", Colors.red),
    DataItem(0.3, "B", Colors.blue),
    DataItem(0.05, "C", Colors.green),
    DataItem(0.2, "D", Colors.yellow),
    DataItem(0.25, "E", Colors.brown),
  ];

  @override
  State<Dount> createState() => _DountState();
}

class _DountState extends State<Dount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        child: Container(),
        painter: DonutChartPainter(widget.dataset),
      ),
    );
  }
}

class DataItem {
  final double value;
  final String label;
  final Color color;
  DataItem(this.value, this.label, this.color);
}

class DonutChartPainter extends CustomPainter {
  final List<DataItem> dataset;
  DonutChartPainter(this.dataset);

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2.0, size.height / 2.0);
    final radius = size.width * 0.9;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);
    var startAngle = 0.0;
    dataset.forEach((di) {
      final sweepAngle = di.value * 360.0 * pi / 180.0;
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = di.color;

      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      // draw line
      final dx = radius / 0.2 * cos(startAngle);
      final dy = radius / 0.2 * sin(startAngle);
      startAngle += sweepAngle;
      print("${di.label} ${di.value}");
    });
  }

  @override
  bool shouldRepaint(DonutChartPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(DonutChartPainter oldDelegate) => false;
}
