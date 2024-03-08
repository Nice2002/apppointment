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
      body: SingleChildScrollView(
        child: Center(
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
                        offset: const Offset(
                            0.0, 1.0), // changes position of shadow
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
                                    "assets/images/std2.jpg",
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
                                  'นายธรรมนูญ เหมือนสิงห์',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'หลักสูตรสาขาวิชาวิทยาการคอมพิวเตอร์',
                                  style: TextStyle(
                                    fontSize: 16,
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
                                  'วันที่      :  20 มกราคม 2567',
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
                                  'สถานที่   :  ห้องพัก 7-317/1',
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
                                  'ปรึกษาโครงงานจบการศึกษา',
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
                              'ปรึกษาโครงงานจบการศึกษาภาควิชาวิทยาการคอมพิวเตอร์และสารสนเทศ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Divider(),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'ระดับความสำคัญ: ปกติ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'ช่องทางการติดต่อ:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.email),
                                const Text(
                                  ' : tammanoon.m@ku.th',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     const Text(
                            //       'ไลน์:',
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //     const Text(
                            //       ' tammanoon2545',
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: [
                            //     const Text(
                            //       'เบอร์โทรศัพท์:',
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //     const Text(
                            //       ' 0981410472',
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: [
                            //     const Text(
                            //       'เฟซบุ๊ก:',
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //     const Text(
                            //       ' Tammanoon Muensing',
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Divider(),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                width: 300,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  onTap: () {},
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
                                  onTap: () {},
                                  child: const Center(
                                    child: Text(
                                      "ลบนัดหมาย",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
