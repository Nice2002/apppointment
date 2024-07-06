import 'dart:convert';
import 'package:apppointment/Colors/app_color.dart';
import 'package:apppointment/api/login_api.dart';
import 'package:apppointment/bottom_navigator/bottom_navigator.dart';
import 'package:apppointment/page/forgot-password.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;
// import 'package:ui_appt/Colors/app_color.dart';
// import 'package:ui_appt/ui/forgot-password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<LoginResponse> verifyLogin() async {
    final body = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    print('Email entered: ${body['email']}');

    final response = await http.post(
      Uri.parse('https://appt-cis.smt-online.com/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "*/*",
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      },
      body: jsonEncode(body),
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = jsonDecode(response.body);

      if (data != null) {
        return LoginResponse.fromJson(data);
      } else {
        throw Exception('Failed to decode JSON data');
      }
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: "เข้าสู่ระบบไม่สำเร็จ",
        desc: "อีเมลหรือรหัสผ่านไม่ถูกต้อง",
        btnOkOnPress: () {},
      ).show();
      throw Exception('Failed to Login.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 350,
            child: Image.asset(
              "assets/images/login.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Form(
            key: _loginForm,
            child: Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.50,
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Color.fromARGB(255, 0, 0, 0),
                  //     offset: Offset(0, 0),
                  //     blurRadius: 10,
                  //     blurStyle: BlurStyle.outer,
                  //   )
                  // ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "ลงชื่อเข้าใช้งาน",
                      style: GoogleFonts.kanit(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 0, 116, 211),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Text(
                      "ลงชื่อเข้าใช้เลย นัดหมายสำคัญกำลังรอคุณอยู่...",
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(131, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(19, 0, 0, 0),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกอิเมล';
                          }
                          return null;
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(137, 0, 102, 255),
                              width: 2.0,
                            ),
                          ),
                          hintText: "อีเมล",
                          hintStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          prefixIcon: const Icon(Icons.email_outlined),
                          prefixIconColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(19, 0, 0, 0),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกรหัสผ่าน';
                          }
                          return null;
                        },
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(137, 0, 102, 255),
                              width: 2.0,
                            ),
                          ),
                          hintText: "รหัสผ่าน",
                          hintStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          prefixIcon: const Icon(EneftyIcons.lock_2_outline),
                          prefixIconColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_loginForm.currentState!.validate()) {
                          print('Login in Progress');
                          LoginResponse res = await verifyLogin();

                          if (res.status == 1) {
                            globals.isLoggedIn = true;
                            globals.jwtToken = res.jwtToken;
                            print('Login Success');
                          }
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.topSlide,
                            showCloseIcon: true,
                            title: "เข้าสู่ระบบสำเร็จ",
                            btnOkOnPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigatorScreen(
                                          user_id: res.userId,
                                          IndexPage: 0,
                                          roleUser: res.roleUser,
                                          prefix: res.prefix,
                                          firstName: res.firstName,
                                          lastName: res.lastName,
                                        )),
                              );
                            },
                          ).show();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 116, 211),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "เข้าสู่ระบบ",
                            style: GoogleFonts.kanit(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ForgotPasswordScreen()));
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => ForgotPasswordScreen());
                            },
                            child: Text(
                              "ลืมรหัสผ่าน",
                              style: GoogleFonts.kanit(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
