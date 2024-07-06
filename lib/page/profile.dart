import 'package:apppointment/Colors/app_color.dart';
import 'package:apppointment/api/appointments_count_api.dart';
import 'package:apppointment/api/user_api.dart';
import 'package:apppointment/page/convenient_day.dart';
import 'package:apppointment/page/changepassword.dart';
import 'package:apppointment/page/contact.dart';
import 'package:apppointment/page/dialog_edit_profile.dart';
import 'package:apppointment/page/history.dart';
import 'package:apppointment/page/login.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class Profile extends StatefulWidget {
  final int user_id;
  const Profile(this.user_id, {Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserModel> futureUser;

  @override
  void initState() {
    futureUser = fetchUser(widget.user_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(
              EneftyIcons.user_tag_outline,
              size: 35,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "โปรไฟล์",
              style: GoogleFonts.kanit(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
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
                            width: 120,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
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
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5, left: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: AppColors.primaryColor,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ชื่อ:",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      child: Row(
                                        children: [
                                          Text(
                                            "${user.prefix} ${user.firstName} ${user.lastName}",
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
                                  color: AppColors.primaryColor,
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
                                    Text(
                                      "อีเมล:",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 250,
                                      child: Row(
                                        children: [
                                          Text(
                                            user.email,
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
                          user.roleUser == 0
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(),
                          user.roleUser == 0
                              ? Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: AppColors.primaryColor,
                                      ),
                                      child: const Icon(
                                        Icons.assignment_ind,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "รหัสนิสิต:",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 250,
                                            child: Row(
                                              children: [
                                                Text(
                                                  user.studentId,
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
                                )
                              : SizedBox(),
                          user.roleUser == 0
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(),
                          user.roleUser == 0
                              ? Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: AppColors.primaryColor,
                                      ),
                                      child: Icon(
                                        Icons.branding_watermark,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "หลักสูตร:",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 250,
                                            child: Row(
                                              children: [
                                                Text(
                                                  user.courseName,
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
                                )
                              : SizedBox(),
                          user.roleUser == 0
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(),
                          user.roleUser == 0
                              ? Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: AppColors.primaryColor,
                                      ),
                                      child: const Icon(
                                        Icons.menu_book,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "ชั้นปี:",
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
                                                  "3",
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
                                )
                              : SizedBox()
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
                        user.roleUser == 1
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ConvenientDay(widget.user_id),
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
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        user.roleUser == 1
                            ? Padding(
                                padding: EdgeInsets.only(right: 10, left: 10),
                                child: Divider(),
                              )
                            : SizedBox(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Context(widget.user_id, user.email)),
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
                                  builder: (context) =>
                                      Histroy(widget.user_id)),
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
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.question,
                              animType: AnimType.topSlide,
                              showCloseIcon: true,
                              title: "ยืนยันออกจากระบบ?",
                              desc: "คุณต้องการออกจากระบบใช่หรือไม่?",
                              btnCancelOnPress: () {},
                              btnOkOnPress: () async {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.topSlide,
                                  showCloseIcon: true,
                                  title: "ออกจากระบบสำเร็จ",
                                  btnOkOnPress: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()),
                                    );
                                  },
                                ).show();
                              },
                            ).show();
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
              );
            }
          },
        ),
      ),
    );
  }
}
