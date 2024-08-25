import 'package:apppointment/Colors/app_color.dart';
import 'package:apppointment/api/user_api.dart';
import 'package:apppointment/page/changepassword.dart';
import 'package:apppointment/page/contact.dart';
import 'package:apppointment/page/convenient_day.dart';
import 'package:apppointment/page/dialog_edit_profile.dart';
import 'package:apppointment/page/history.dart';
import 'package:apppointment/page/login.dart';
import 'package:apppointment/page/login_2.dart';
import 'package:apppointment/page/perosnal_infomation.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class ProfileScreen extends StatefulWidget {
  final int user_id;
  final String prefix;
  final String firstName;
  final String lastName;
  const ProfileScreen(this.user_id, this.prefix, this.firstName, this.lastName,
      {Key? key})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserModel> futureUser;

  @override
  void initState() {
    futureUser = fetchUser(widget.user_id);
    super.initState();
  }

  Future<void> logout() async {
    final response = await http.post(
      Uri.parse('https://appt-cis.smt-online.com/api/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      },
    );

    if (response.statusCode == 200) {
      print('ออกจากระบบสำเร็จ');
      globals.jwtToken = '';
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      throw Exception('Failed to logout data to the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Icon(
              EneftyIcons.user_tag_bold,
              size: 30,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "โปรไฟล์",
              style: GoogleFonts.kanit(
                textStyle:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<UserModel>(
          future: futureUser,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (userSnapshot.hasError) {
              return Center(
                  child: Text('เกิดข้อผิดพลาด: ${userSnapshot.error}'));
            } else if (!userSnapshot.hasData) {
              return Center(child: Text('ไม่มีข้อมูล'));
            } else {
              final user = userSnapshot.data!;
              final String imageUrl =
                  'https://appt-cis.smt-online.com/api/public/${user.imageProfile}';

              print(imageUrl);
              return Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.30,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                imageUrl,
                                headers: {
                                  'Authorization': 'Bearer ' + globals.jwtToken,
                                },
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      Dialog_Edit_Profile(user.id));
                            },
                            child: Center(child: Icon(Icons.edit)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${user.prefix}${user.firstName} ${user.lastName}",
                        style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "${user.email}",
                        style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            /// personal infomation
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PersonalInformationScreen(
                                      user.id,
                                      user.roleUser,
                                      imageUrl,
                                      user.email,
                                      user.prefix,
                                      user.firstName,
                                      user.lastName,
                                      user.studentId,
                                      user.courseName,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          69, 185, 185, 185),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              EneftyIcons.user_outline,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "ข้อมูลส่วนตัว",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          EneftyIcons.arrow_right_3_outline,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            /// time date
                            user.roleUser == 1
                                ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConvenientDay(widget.user_id)),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7.5),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                69, 185, 185, 185),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    EneftyIcons
                                                        .calendar_add_outline,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "วันเวลาที่สะดวก",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                EneftyIcons
                                                    .arrow_right_3_outline,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),

                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Contact(widget.user_id, user.email)),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          69, 185, 185, 185),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              EneftyIcons.call_outline,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "ช่องทางการติดต่อ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          EneftyIcons.arrow_right_3_outline,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            /// contect
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Histroy(widget.user_id)),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          69, 185, 185, 185),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              EneftyIcons.message_time_outline,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "ประวัติการนัดหมาย",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          EneftyIcons.arrow_right_3_outline,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            /// contect
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangePassword()),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          69, 185, 185, 185),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              EneftyIcons.key_outline,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "เปลี่ยนรหัสผ่าน",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          EneftyIcons.arrow_right_3_outline,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            /// logout
                            InkWell(
                              onTap: () {
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.topSlide,
                                    showCloseIcon: true,
                                    title: "ยืนยันออกจากระบบ?",
                                    desc: "คุณต้องการออกจากระบบใช่หรือไม่?",
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () async {
                                      await logout();
                                    }).show();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.5),
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            69, 185, 185, 185),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            EneftyIcons.logout_2_outline,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "ออกจากระบบ",
                                            style: GoogleFonts.kanit(
                                                textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red,
                                            )),
                                          )
                                        ],
                                      ),
                                    )),
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
          },
        ),
      ),
    );
  }
}
