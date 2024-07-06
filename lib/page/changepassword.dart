import 'dart:convert';
import 'package:apppointment/Colors/app_color.dart';
import 'package:apppointment/api/updatePassword_api.dart';
import 'package:apppointment/page/login.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/globals.dart' as globals;
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _updatepassword = GlobalKey<FormState>();
  final _CurrentPassword = TextEditingController();
  final _NewPassword = TextEditingController();
  final _ConfirmNewPassword = TextEditingController();

  Future<UpdatPassword> fetchUpdatePassword() async {
    final body = {
      'current_password': _CurrentPassword.text,
      'new_password': _NewPassword.text,
    };
    final response = await http.post(
      Uri.parse('https://appt-cis.smt-online.com/api/user/changePassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '/',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      },
      body: jsonEncode(body),
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final user = UpdatPassword.fromJson(data);
      return user;
    } else {
      throw Exception('Failed to update data to the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เปลี่ยนรหัสผ่าน'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _updatepassword,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'รหัสผ่านปัจจุบัน',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  // Container(
                  //   height: 55,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(
                  //       color: const Color.fromARGB(255, 13, 187, 158),
                  //     ),
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black.withOpacity(0.1),
                  //         spreadRadius: 1.0,
                  //         blurRadius: 3.0,
                  //         offset: const Offset(0.0, 1.0),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Theme(
                  //     data: ThemeData(
                  //       inputDecorationTheme: InputDecorationTheme(
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 15),
                  //       child: TextFormField(
                  //         controller: _CurrentPassword,
                  //         decoration: InputDecoration(
                  //           hintText: 'รหัสผ่านปัจจุบัน',
                  //           hintStyle: TextStyle(
                  //             fontSize: 16.0,
                  //             fontFamily: GoogleFonts.prompt().fontFamily,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(19, 0, 0, 0),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: _CurrentPassword,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(137, 0, 102, 255),
                            width: 2.0,
                          ),
                        ),
                        hintText: "กรอกรหัสผ่านปัจจุบัน",
                        hintStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        prefixIconColor: AppColors.primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'รหัสผ่านใหม่',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(19, 0, 0, 0),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: _NewPassword,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(137, 0, 102, 255),
                            width: 2.0,
                          ),
                        ),
                        hintText: "กรอกรหัสผ่านใหม่",
                        hintStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        prefixIconColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 55,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(
                  //       color: const Color.fromARGB(255, 13, 187, 158),
                  //     ),
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black.withOpacity(0.1),
                  //         spreadRadius: 1.0,
                  //         blurRadius: 3.0,
                  //         offset: const Offset(0.0, 1.0),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Theme(
                  //     data: ThemeData(
                  //       inputDecorationTheme: InputDecorationTheme(
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 15),
                  //       child: TextFormField(
                  //         controller: _NewPassword,
                  //         decoration: InputDecoration(
                  //           hintText: 'รหัสผ่านใหม่',
                  //           hintStyle: TextStyle(
                  //             fontSize: 16.0,
                  //             fontFamily: GoogleFonts.prompt().fontFamily,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'ยืนยันรหัสผ่านใหม่',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(19, 0, 0, 0),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: _ConfirmNewPassword,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(137, 0, 102, 255),
                            width: 2.0,
                          ),
                        ),
                        hintText: "ยืนยันรหัสผ่านใหม่",
                        hintStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        prefixIconColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 55,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(
                  //       color: const Color.fromARGB(255, 13, 187, 158),
                  //     ),
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black.withOpacity(0.1),
                  //         spreadRadius: 1.0,
                  //         blurRadius: 3.0,
                  //         offset: const Offset(0.0, 1.0),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Theme(
                  //     data: ThemeData(
                  //       inputDecorationTheme: InputDecorationTheme(
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 15),
                  //       child: TextFormField(
                  //         controller: _ConfirmNewPassword,
                  //         decoration: InputDecoration(
                  //           hintText: 'ยืนยันรหัสผ่านใหม่',
                  //           hintStyle: TextStyle(
                  //             fontSize: 16.0,
                  //             fontFamily: GoogleFonts.prompt().fontFamily,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                  //         AwesomeNotifications().createNotification(
                  //           content: NotificationContent(
                  //             id: 3,
                  //             channelKey: "basic_channel",
                  //             title: "แจ้งเตือนคำขอนัดหมาย",
                  //             body: "ในวันที่ 16 มกราคม 2567 เวลา 11.00-12.30 น.",
                  //             color: Colors.deepPurple,
                  //           ),
                  //         );
                  //       },
                  //       child: const Center(
                  //         child: Text(
                  //           "เปลี่ยนรหัสผ่าน",
                  //           style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 116, 211),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (_NewPassword.text == _ConfirmNewPassword.text) {
                            // Compare text values
                            print("รหัสผ่านตรงกัน");
                            if (_updatepassword.currentState!.validate()) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.question,
                                animType: AnimType.topSlide,
                                showCloseIcon: true,
                                title: "ยืนยันการแก้ไข ?",
                                desc: "คุณต้องการเปลี่ยนรหัสผ่านใช่หรือไม่?",
                                btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                                  UpdatPassword res =
                                      await fetchUpdatePassword();
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.topSlide,
                                    showCloseIcon: true,
                                    title: "เปลี่ยนรหัสผ่านสำเร็จ",
                                    btnOkOnPress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                      );
                                    },
                                  ).show();
                                  print("object");
                                },
                              ).show();
                            }
                          } else {
                            print("รหัสผ่านไม่ตรงกัน");
                          }
                        },
                        child: const Center(
                          child: Text(
                            "เปลี่ยนรหัสผ่าน",
                            style: TextStyle(
                                fontSize: 18,
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
          ),
        ),
      ),
      // persistentFooterButtons: [
      //   Center(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 30),
      //       child: Container(
      //         height: 50,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           color: const Color.fromARGB(255, 13, 187, 158),
      //         ),
      //         child: InkWell(
      //           onTap: () {
      //             if (_NewPassword.text == _ConfirmNewPassword.text) {
      //               // Compare text values
      //               print("รหัสผ่านตรงกัน");
      //               if (_updatepassword.currentState!.validate()) {
      //                 AwesomeDialog(
      //                   context: context,
      //                   dialogType: DialogType.question,
      //                   animType: AnimType.topSlide,
      //                   showCloseIcon: true,
      //                   title: "ยืนยันการแก้ไข ?",
      //                   desc: "คุณต้องการเปลี่ยนรหัสผ่านใช่หรือไม่?",
      //                   btnCancelOnPress: () {},
      //                   btnOkOnPress: () async {
      //                     UpdatPassword res = await fetchUpdatePassword();
      //                     AwesomeDialog(
      //                       context: context,
      //                       dialogType: DialogType.success,
      //                       animType: AnimType.topSlide,
      //                       showCloseIcon: true,
      //                       title: "เปลี่ยนรหัสผ่านสำเร็จ",
      //                       btnOkOnPress: () {
      //                         Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                               builder: (context) => Login()),
      //                         );
      //                       },
      //                     ).show();
      //                     print("object");
      //                   },
      //                 ).show();
      //               }
      //             } else {
      //               print("รหัสผ่านไม่ตรงกัน");
      //             }
      //           },
      //           child: const Center(
      //             child: Text(
      //               "เปลี่ยนรหัสผ่าน",
      //               style: TextStyle(
      //                   fontSize: 18,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.white),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}
