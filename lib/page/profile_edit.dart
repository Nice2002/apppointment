import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'แก้ไขชื่อ',
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'แก้ไขชื่อ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromARGB(255, 13, 187, 158),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1.0,
                    blurRadius: 3.0,
                    offset: const Offset(0.0, 1.0),
                  ),
                ],
              ),
              child: Theme(
                data: ThemeData(
                  inputDecorationTheme: InputDecorationTheme(
                    border: InputBorder.none,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'กรอกชื่อ',
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontFamily: GoogleFonts.prompt().fontFamily,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: 50,
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
                  // AwesomeNotifications().createNotification(
                  //   content: NotificationContent(
                  //     id: 3,
                  //     channelKey: "basic_channel",
                  //     title: "แจ้งเตือนคำขอนัดหมาย",
                  //     body: "ในวันที่ 16 มกราคม 2567 เวลา 11.00-12.30 น.",
                  //     color: Colors.deepPurple,
                  //   ),
                  // );
                },
                child: const Center(
                  child: Text(
                    "ยืนยันแก้ไขชื่อ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
