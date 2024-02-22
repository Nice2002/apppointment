import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class Message_Confirm extends StatefulWidget {
  const Message_Confirm({super.key});

  @override
  State<Message_Confirm> createState() => _Message_ConfirmState();
}

class _Message_ConfirmState extends State<Message_Confirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียด'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  // border: Border.all(
                  //   color: Colors.black,
                  //   width: 2.0,
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 3.0,
                      blurRadius: 5.0,
                      offset:
                          const Offset(0.0, 1.0), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            "assets/images/teacher.png",
                            height: 100,
                            width: 97,
                          ),
                          Text(
                            '      อาจารย์ อัจฉรา นามบุรี',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '   วันที่       :  15 มกราคม 2567',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          // Text(
                          //   '   15 มกราคม 2567',
                          //   style: TextStyle(
                          //     fontSize: 18,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '   เวลา       :  11.00-12.30 น.',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '   สถานที่    :  อาคาร 7 ห้อง 114/2',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'เรื่อง ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'ปรึกษาโครงงานจบการศึกษา',
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'รายละเอียด',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'นัดหมายเพื่อสอบถามเกี่ยวกับโครงงานจบการศึกษาค่ะ',
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          'ต้องการนัดหมายหรือไม่ ?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 13, 187, 158),
                          ),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ChangePassword()));
                              AwesomeNotifications().createNotification(
                                content: NotificationContent(
                                  id: 3,
                                  channelKey: "basic_channel",
                                  title: "Notification test",
                                  body: "Notification test",
                                  color: Colors.deepPurple,
                                ),
                              );
                            },
                            child: const Center(
                              child: Text(
                                "ยืนยันนัดหมาย",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Container(
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 255, 217, 4),
                          ),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ChangePassword()));
                            },
                            child: const Center(
                              child: Text(
                                "แก้ไขนัดหมาย",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Container(
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ChangePassword()));
                            },
                            child: const Center(
                              child: Text(
                                "ปฏิเสธนัดหมาย",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
