import 'package:apppointment/page-2/index.dart';
import 'package:apppointment/page/home.dart';
import 'package:apppointment/page/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                          controller: emailController,
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
                        onTap: () {
                          if (emailController.text == "6440201793" &&
                              passwordController.text == "6440201793") {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Index()));
                          } else {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const IndexAJ()));
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
