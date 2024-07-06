import 'dart:convert';
import 'package:apppointment/bottom_navigator/bottom_navigator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:apppointment/api/login_api.dart';
import 'package:apppointment/page/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginForm = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  Future<LoginResponse> verifyLogin() async {
    final body = {
      'email': usernameController.text,
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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Form(
            key: _loginForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "เข้าสู่ระบบ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                const Center(
                  child: Text(
                    "หากเข้าสู่ระบบครั้งแรกจะต้องเข้ารหัสผ่านที่กำหนดไว้",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 50),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       'กรอกรหัสนิสิตหรืออีเมล',
                //       style: TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
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
                        padding: EdgeInsets.only(left: 15),
                        child: TextFormField(
                          controller: usernameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'กรอกอีเมล',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              fontFamily: GoogleFonts.prompt().fontFamily,
                            ),
                            prefixIcon: Icon(Icons.email_rounded),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
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
                        padding: EdgeInsets.only(left: 15),
                        child: TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'กรอกรหัสผ่าน',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              fontFamily: GoogleFonts.prompt().fontFamily,
                            ),
                            prefixIcon: Icon(Icons.key),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                                      builder: (context) =>
                                          BottomNavigatorScreen(
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
                        child: const Center(
                          child: Text(
                            "เข้าสู่ระบบ",
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
            ),
          ),
        ],
      ),
    );
  }
}
