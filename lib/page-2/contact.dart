import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Context extends StatefulWidget {
  const Context({super.key});

  @override
  State<Context> createState() => _ContextState();
}

class _ContextState extends State<Context> {
  List<int> selectedContexts = [];

  void _contextsCheckboxChanged(int index) {
    setState(() {
      if (selectedContexts.contains(index)) {
        selectedContexts.remove(index);
      } else {
        selectedContexts.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ช่องทางการติดต่อ'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'เลือกช่องทางการติดต่อเพื่อแสดงในข้อมูลการนัดหมาย',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: selectedContexts.contains(0),
                        onChanged: (value) {
                          _contextsCheckboxChanged(0);
                        },
                        title: Text('อีเมล'),
                      ),
                    ),
                    if (selectedContexts.contains(0))
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "adchara.n@lve.ku.th",
                        ),
                      ),
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: selectedContexts.contains(1),
                        onChanged: (value) {
                          _contextsCheckboxChanged(1);
                        },
                        title: Text('ไลน์'),
                      ),
                    ),
                    if (selectedContexts.contains(1))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
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
                                  hintText: 'ไลน์',
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
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: selectedContexts.contains(2),
                        onChanged: (value) {
                          _contextsCheckboxChanged(2);
                        },
                        title: Text('เบอร์โทรศัพท์'),
                      ),
                    ),
                    if (selectedContexts.contains(2))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
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
                                  hintText: 'เบอร์โทรศัพท์',
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
                    Container(
                      height: 45,
                      child: CheckboxListTile(
                        value: selectedContexts.contains(3),
                        onChanged: (value) {
                          _contextsCheckboxChanged(3);
                        },
                        title: Text('เฟซบุ๊ก'),
                      ),
                    ),
                    if (selectedContexts.contains(3))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
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
                                  hintText: 'เฟซบุ๊ก',
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
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 30,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30),
              //   child: Container(
              //     height: 50,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: const Color.fromARGB(255, 13, 187, 158),
              //     ),
              //     child: InkWell(
              //       onTap: () {
              //         // Navigator.push(
              //         //     context,
              //         //     MaterialPageRoute(
              //         //         builder: (context) => ChangePassword()));
              //         // AwesomeNotifications().createNotification(
              //         //   content: NotificationContent(
              //         //     id: 3,
              //         //     channelKey: "basic_channel",
              //         //     title: "แจ้งเตือนคำขอนัดหมาย",
              //         //     body: "ในวันที่ 16 มกราคม 2567 เวลา 11.00-12.30 น.",
              //         //     color: Colors.deepPurple,
              //         //   ),
              //         // );
              //       },
              //       child: const Center(
              //         child: Text(
              //           "บันทึกข้อมูล",
              //           style: TextStyle(
              //               fontSize: 18,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.white),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: Padding(
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
                  //         builder: (context) => const Index()));
                },
                child: const Center(
                  child: Text(
                    "บันทึกข้อมูล",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
