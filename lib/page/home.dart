import 'package:apppointment/widget/chart.dart';
import 'package:apppointment/widget/donut2.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget implements PreferredSizeWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomepageState extends State<Homepage> {
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
              Icons.home,
              size: 35,
            ),
            SizedBox(width: 10),
            Text(
              "หน้าแรก",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "รายงานจำนวนการนัดหมาย",
                        style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ประจำเดือนมกราคม ปี 2567",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 13, 187, 158),
                              width: 2,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2.0,
                                blurRadius: 2.0,
                                offset: const Offset(0.0, 1.0),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'จำนวนการนัดหมายสำเร็จ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    ' 2 ',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    'ครั้ง',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2.0,
                                blurRadius: 2.0,
                                offset: const Offset(0.0, 1.0),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'จำนวนการรอนัดหมาย',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    ' 5 ',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    'ครั้ง',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: 2,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2.0,
                                blurRadius: 2.0,
                                offset: const Offset(0.0, 1.0),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'จำนวนการปฏิเสธนัดหมาย',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    ' 4 ',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    'ครั้ง',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "รายงานจำนวนการนัดหมายทั้งหมดในระบบ",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(255, 13, 187, 158),
                          width: 2,
                        ),
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
                            height: 30,
                          ),
                          // Chart(),
                          DonutChart(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
