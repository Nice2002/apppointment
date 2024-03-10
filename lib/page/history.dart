import 'package:apppointment/page/history_detail.dart';
import 'package:apppointment/widget/donut_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                child: const Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    // Chart(),
                    DonutProfile(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            buildAppointmentList(),
          ],
        ),
      ),
    );
  }

  Widget buildAppointmentList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
              images: 'assets/images/teacher1.jpg',
              status: 'สำเร็จ',
              priority: 'ปกติ',
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
              lecturer: 'ผู้ช่วยศาสตราจารย์ ดร.จารุวัฒน์ ไพใหล',
              images: 'assets/images/teacher2.jpg',
              status: 'ปฏิเสธ',
              priority: 'ปกติ',
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
              lecturer: 'ผู้ช่วยศาสตราจารย์จิตสราญ สีกู่กา',
              images: 'assets/images/teacher3.jpg',
              status: 'ปฏิเสธ',
              priority: 'ปกติ',
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
    required String images,
    required String priority,
  }) {
    return Padding(
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
                      Container(
                        width: 60,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 238, 237, 237),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Color.fromARGB(255, 170, 170, 170),
                          //     blurRadius: 10,
                          //     offset: Offset(0, 5),
                          //   )
                          // ]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            images,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lecturer,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          SizedBox(
                            width: 250,
                            child: Text(
                              "วันที่: $date",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          SizedBox(
                            width: 250,
                            child: Text(
                              "เวลา: $time",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          SizedBox(
                            width: 250,
                            child: Text(
                              "เรื่อง: $topic",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            status,
                            style: TextStyle(
                              color: getStatusColor(index),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'ความสำคัญ: $priority',
                        style: TextStyle(
                          fontSize: 14,
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
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 13, 187, 158),
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
