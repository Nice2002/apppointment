import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apppointment/page/message_confirm.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    List<String> items = [
      "ขอนัดหมายจากอาจารย์",
      "ขอนัดหมายของฉัน",
    ];
    int current = 0;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          elevation: 3,
          automaticallyImplyLeading: false,
          title: const Row(
            children: [
              Icon(
                Icons.message,
                size: 35,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "คำร้องขอนัดหมาย",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'ขอนัดหมายของอาจารย์'),
                Tab(text: 'ขอนัดหมายของฉัน'),
              ],
            ),
            Expanded(
                child: TabBarView(
              children: [
                buildAppointmentList(),
                buildAppointmentList2(),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     // Padding(
                //     //   padding: EdgeInsets.all(20.0),
                //     //   child: SizedBox(
                //     //       width: 300,
                //     //       child: Image.asset("assets/images/not_app.png")),
                //     // ),
                //     // const Text(
                //     //   "ไม่มีคำขอนัดหมาย",
                //     //   style:
                //     //       TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                //     // ),

                //   ],
                // ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildAppointmentList() {
    return ListView.builder(
      // shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildAppointmentCard(
              image: 'assets/images/teacher1.jpg',
              date: '18 มกราคม 2567',
              time: '11.00-12.30 น.',
              topic: 'ปรึกษาโครงงานจบการศึกษา',
              lecturer: 'อาจารย์อัจฉรา นามบุรี',
              status: 'รอยืนยัน',
              index: index,
            ),
          );
        } else if (index == 1) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildAppointmentCard(
              image: 'assets/images/teacher2.jpg',
              date: '19 มกราคม 2567',
              time: '09.30-10.30 น.',
              topic: 'ประเมินผลการทดลอง',
              lecturer: 'อาจารย์จารุวัฒน์ ไพใหล',
              status: 'รอยืนยัน',
              index: index,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildAppointmentCard(
              image: 'assets/images/teacher3.jpg',
              date: '19 มกราคม 2567',
              time: '14.00-15.30 น.',
              topic: 'สรุปโครงการวิจัย',
              lecturer: 'อาจารย์จิตสราญ สีกู่กา',
              status: 'รอยืนยัน',
              index: index,
            ),
          );
        }
      },
    );
  }

  Widget buildAppointmentList2() {
    return ListView.builder(
      // shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildAppointmentCard(
              image: 'assets/images/teacher1.jpg',
              date: '18 มกราคม 2567',
              time: '11.00-12.30 น.',
              topic: 'ปรึกษาโครงงานจบการศึกษา',
              lecturer: 'อาจารย์อัจฉรา นามบุรี',
              status: 'รอยืนยัน',
              index: index,
            ),
          );
        }
      },
    );
  }

  Widget buildAppointmentCard({
    required String image,
    required String date,
    required String time,
    required String topic,
    required String lecturer,
    required String status,
    required int index,
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
                      ClipRRect(
                        child: Image.asset(
                          image,
                          height: 100,
                        ),
                        borderRadius: BorderRadius.circular(7),
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "วันที่: $date",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "เวลา: $time",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "เรื่อง: $topic",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
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
                        "สถานะ: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        status,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 116, 116, 116),
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
                            builder: (context) => const Message_Confirm(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
