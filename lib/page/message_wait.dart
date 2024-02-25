import 'package:flutter/material.dart';

class Message_Wait extends StatefulWidget {
  const Message_Wait({super.key});

  @override
  State<Message_Wait> createState() => _Message_WaitState();
}

class _Message_WaitState extends State<Message_Wait> {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              'รอยืนยันนัดหมาย',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                  "assets/images/teacher1.jpg",
                                  height: 130,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'อาจารย์อัจฉรา นามบุรี',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(Icons.date_range),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'วันที่      :  16 มกราคม 2567',
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
                              Icon(
                                Icons.access_time_sharp,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'เวลา      :  9.00-12.00 น.',
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
                              Icon(Icons.business),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'สถานที่   :  ห้อง 7-317',
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
                            height: 10,
                          ),
                          Divider(),
                          const Row(
                            children: [
                              Text(
                                'เรื่อง: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'ส่งรายงานความก้าวหน้าโครงงาน',
                                style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Divider(),
                          const Row(
                            children: [
                              Text(
                                'รายละเอียด:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'ยินดีต้อนรับสู่คลิปบอร์ดของ Gboard ข้อความที่คุณคัดลอกจะบันทึกไว้ที่นี่ยินดีต้อนรับสู่คลิปบอร์ดของ Gboard ข้อความที่คุณคัดลอกจะบันทึกไว้ที่นี่ยินดีต้อนรับสู่คลิปบอร์ดของ Gboard ข้อความที่คุณคัดลอกจะบันทึกไ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
