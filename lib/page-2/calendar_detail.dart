import 'package:flutter/material.dart';

class CalendarDetail extends StatefulWidget {
  const CalendarDetail({Key? key}) : super(key: key);

  @override
  State<CalendarDetail> createState() => _CalendarDetailState();
}

class _CalendarDetailState extends State<CalendarDetail> {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                                'รอวันนัดหมาย',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
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
                                  'เวลา      :  15.00-16.00 น.',
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
                                  'Homeroom ภาควิชา',
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
                            SizedBox(
                              width: 320,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'ปรึกษาโครงงานจบการศึกษาภาควิชาวิทยาการคอมพิวเตอร์และสารสนเทศ ',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'ระดับความสำคัญ: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'เร่งด่วน',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            SizedBox(
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
                                  ' : tammanoon.m@.ku.th',
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
