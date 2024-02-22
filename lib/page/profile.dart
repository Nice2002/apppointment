import 'package:apppointment/page/addTimeOpenClose.dart';
import 'package:apppointment/page/changepassword.dart';
import 'package:apppointment/page/convenient.dart';
import 'package:apppointment/page/profile_dashboard.dart';
import 'package:apppointment/page/profile_edit.dart';
import 'package:apppointment/page/history.dart';
import 'package:apppointment/page/login.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              Icons.person,
              size: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "โปรไฟล์",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/student.png",
                height: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromARGB(255, 13, 187, 158),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "ชื่อ",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 250,
                                child: const Row(
                                  children: [
                                    Text(
                                      "ธรรมนูญ เหมือนสิงห์",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromARGB(255, 13, 187, 158),
                          ),
                          child: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "อีเมล",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 250,
                                child: const Row(
                                  children: [
                                    Text(
                                      "tammanoon.m@ku.th",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromARGB(255, 13, 187, 158),
                          ),
                          child: const Icon(
                            Icons.assignment_ind,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "รหัสนิสิต",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 250,
                                child: const Row(
                                  children: [
                                    Text(
                                      "6440201793",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromARGB(255, 13, 187, 158),
                          ),
                          child: const Icon(
                            Icons.branding_watermark,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "หลักสูตร",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 250,
                                child: const Row(
                                  children: [
                                    Text(
                                      "วิทยาการคอมพิวเตออร์",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Divider(
                  color: const Color.fromARGB(255, 13, 187, 158),
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AddTimeOpenCloseDialog()),
                      );
                    },
                    child: Container(
                      width: 350,
                      height: 40,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "วันเวลาที่สะดวก",
                              style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(), // หรือ Expanded()
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Divider(
                      color: const Color.fromARGB(255, 13, 187, 158),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangePassword()),
                      );
                    },
                    child: Container(
                      width: 350,
                      height: 40,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(Icons.key),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "เปลี่ยนรหัสผ่าน",
                              style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(), // หรือ Expanded()
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Divider(
                      color: const Color.fromARGB(255, 13, 187, 158),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Histroy()),
                      );
                    },
                    child: Container(
                      width: 350,
                      height: 40,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(Icons.history),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "ประวัติการนัดหมาย",
                              style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(), // หรือ Expanded()
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Divider(
                      color: const Color.fromARGB(255, 13, 187, 158),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashboardProfile()),
                      );
                    },
                    child: Container(
                      width: 350,
                      height: 40,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(Icons.dashboard),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "รายงานการนัดหมายของฉัน",
                              style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(), // หรือ Expanded()
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Divider(
                      color: const Color.fromARGB(255, 13, 187, 158),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: Container(
                      width: 350,
                      height: 40,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(Icons.logout),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "ออกจากระบบ",
                              style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(), // หรือ Expanded()
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Divider(
                      color: const Color.fromARGB(255, 13, 187, 158),
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
