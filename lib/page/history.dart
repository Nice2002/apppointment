import 'package:apppointment/page/history_detail.dart';
import 'package:flutter/material.dart';

class Histroy extends StatefulWidget {
  const Histroy({super.key});

  @override
  State<Histroy> createState() => _HistroyState();
}

class _HistroyState extends State<Histroy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ประวัติการนัดหมาย'),
        ),
        body: Column(children: [
          SingleChildScrollView(
            child: buildAppointmentList(),
          ),
        ]));
  }

  Widget buildAppointmentList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildAppointmentCard(
              date: '2 มกราคม 2567',
              time: '11.00-12.30 น.',
              topic: 'ปรึกษาโครงงานจบการศึกษา',
              lecturer: 'อาจารย์ อัจฉรา นามบุรี',
              status: 'สำเร็จ',
              index: index,
            ),
          );
        } else if (index == 1) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildAppointmentCard(
              date: '1 มกราคม 2567',
              time: '09.30-10.30 น.',
              topic: 'ประเมินผลการทดลอง',
              lecturer: 'อาจารย์ สมศักดิ์ ใจดี',
              status: 'ปฏิเสธ',
              index: index,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildAppointmentCard(
              date: '1 มกราคม 2567',
              time: '14.00-15.30 น.',
              topic: 'สรุปโครงการวิจัย',
              lecturer: 'อาจารย์ วิทยา ความรู้',
              status: 'ปฏิเสธ',
              index: index,
            ),
          );
        }
      },
    );
  }

  Widget buildAppointmentCard({
    required String date,
    required String time,
    required String topic,
    required String lecturer,
    required String status,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
          padding: const EdgeInsets.all(15),
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
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lecturer,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "$date | $time",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "เรื่อง $topic",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 35),
              //       child: Text(
              //         lecturer,
              //         style: const TextStyle(
              //           color: Colors.black,
              //           fontSize: 16,
              //         ),
              //       ),
              //     ),
              //     Text(
              //       status,
              //       style: const TextStyle(
              //         color: Colors.grey,
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),

              // Row(
              //   children: [
              //     const Padding(
              //       padding: EdgeInsets.only(left: 35),
              //       child: Text(
              //         "เรื่อง ",
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 16,
              //         ),
              //       ),
              //     ),
              //     Text(
              //       topic,
              //       style: const TextStyle(
              //         color: Colors.black,
              //         fontSize: 16,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 5),
              const Divider(
                color: Color.fromARGB(255, 13, 187, 158),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row(
                  //   children: [
                  //     const Icon(
                  //       Icons.notifications,
                  //       size: 25,
                  //       color: const Color.fromARGB(255, 13, 187, 158),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "เวลา $time",
                  //           style: const TextStyle(
                  //             color: Colors.black,
                  //             fontSize: 16,
                  //           ),
                  //         ),
                  //         Text(
                  //           "วันที่ $date",
                  //           style: const TextStyle(
                  //             color: Colors.black,
                  //             fontSize: 16,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Text(
                        "สถานะ ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        status,
                        style: TextStyle(
                          color: getStatusColor(index),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
                            builder: (context) => const HistoryDetail(),
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
    );
  }

  Color getStatusColor(int index) {
    switch (index) {
      case 0:
        return const Color.fromARGB(
            255, 13, 187, 158); // Your color for index 0
      case 1:
        return Colors.red; // Your color for index 1
      case 2:
        return Colors.red; // Your color for index 2
      // Add more cases as needed
      default:
        return Colors.black; // Default color
    }
  }
}
