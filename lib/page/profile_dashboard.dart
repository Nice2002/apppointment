import 'package:apppointment/widget/donut2.dart';
import 'package:apppointment/widget/donut_profile.dart';
import 'package:flutter/material.dart';

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State<DashboardProfile> createState() => _DashboardProfileState();
}

class _DashboardProfileState extends State<DashboardProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานการนัดหมายของฉัน'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 370,
              width: 370,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromARGB(255, 13, 187, 158), width: 2),
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
              child: const Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  // Chart(),
                  DonutProfile(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
