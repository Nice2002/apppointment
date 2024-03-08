import 'package:apppointment/page-2/addTimeOpenClose.dart';
import 'package:apppointment/page-2/changepassword.dart';
import 'package:apppointment/page-2/contact.dart';
import 'package:apppointment/page-2/dialog_edit_profile.dart';
import 'package:apppointment/page-2/history.dart';
import 'package:apppointment/page-2/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                fontSize: 20,
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
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 80,
                      height: 100,
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
                          "assets/images/teacher1.jpg",
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog_Edit_Profile());
                      },
                      child: Center(child: Icon(Icons.edit)),
                    )
                  ],
                ),
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
                                "ชื่อ:",
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
                                      "อัจฉรา นามบุรี",
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
                      height: 15,
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
                                "อีเมล:",
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
                                      "adchara.n@live.ku.th",
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
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       height: 50,
                    //       width: 50,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(25),
                    //         color: const Color.fromARGB(255, 13, 187, 158),
                    //       ),
                    //       child: const Icon(
                    //         Icons.assignment_ind,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 20),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           const Text(
                    //             "รหัสนิสิต:",
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //           Container(
                    //             height: 30,
                    //             width: 250,
                    //             child: const Row(
                    //               children: [
                    //                 Text(
                    //                   "6440201793",
                    //                   style: TextStyle(
                    //                     fontSize: 16,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       height: 50,
                    //       width: 50,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(25),
                    //         color: const Color.fromARGB(255, 13, 187, 158),
                    //       ),
                    //       child: const Icon(
                    //         Icons.branding_watermark,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 20),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           const Text(
                    //             "หลักสูตร:",
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //           Container(
                    //             height: 30,
                    //             width: 250,
                    //             child: const Row(
                    //               children: [
                    //                 Text(
                    //                   "วิทยาการคอมพิวเตออร์",
                    //                   style: TextStyle(
                    //                     fontSize: 16,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       height: 50,
                    //       width: 50,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(25),
                    //         color: const Color.fromARGB(255, 13, 187, 158),
                    //       ),
                    //       child: const Icon(
                    //         Icons.menu_book,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 20),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           const Text(
                    //             "ชั้นปี:",
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //           Container(
                    //             height: 30,
                    //             width: 250,
                    //             child: const Row(
                    //               children: [
                    //                 Text(
                    //                   "3",
                    //                   style: TextStyle(
                    //                     fontSize: 16,
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Divider(),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddTimeOpenCloseDialog(),
                        ),
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
                    child: Divider(),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Context()),
                      );
                    },
                    child: Container(
                      width: 350,
                      height: 40,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(Icons.call),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "ช่องทางการติดต่อ",
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
                    child: Divider(),
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
                    child: Divider(),
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
                    child: Divider(),
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
                    child: Divider(),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
