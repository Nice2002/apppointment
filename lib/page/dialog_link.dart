import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dialog_Link extends StatefulWidget {
  const Dialog_Link({super.key});

  @override
  State<Dialog_Link> createState() => _Dialog_LinkState();
}

class _Dialog_LinkState extends State<Dialog_Link> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: 250,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ปีการศึกษา',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Container(
                    height: 50,
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
                            hintText: 'กรอกปีการศึกษา',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              fontFamily: GoogleFonts.prompt().fontFamily,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'เทอม',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Container(
                    height: 50,
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
                            hintText: 'กรอกเทอม',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              fontFamily: GoogleFonts.prompt().fontFamily,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
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
                        //     title: "Notification test",
                        //     body: "Notification test",
                        //     color: Colors.deepPurple,
                        //   ),
                        // );
                      },
                      child: const Center(
                        child: Text(
                          "ค้นหาตารางสอน",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
    );
  }
}
