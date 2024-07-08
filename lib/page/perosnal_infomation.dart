import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class PersonalInformationScreen extends StatefulWidget {
  final int userId;
  final int? roleUser;
  final String imageUrl;
  final String email;
  final String? prefix;
  final String? firstName;
  final String? lastName;
  final String? studentId;
  final String? courseName;

  const PersonalInformationScreen(
      this.userId,
      this.roleUser,
      this.imageUrl,
      this.email,
      this.prefix,
      this.firstName,
      this.lastName,
      this.studentId,
      this.courseName,
      {Key? key})
      : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ข้อมูลส่วนตัว",
          style: GoogleFonts.kanit(
              textStyle: const TextStyle(
            fontSize: 16,
          )),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.43,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 228, 228, 228),
                offset: Offset(0, 0),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
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
                      widget.imageUrl,
                      headers: {
                        'Authorization': 'Bearer ' + globals.jwtToken,
                      },
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (widget.roleUser == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ชื่อ-นามสกุล: ",
                        style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.prefix}${widget.firstName} ${widget.lastName}",
                        style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (widget.roleUser == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "คำนามหน้าชื่อ: ",
                        style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.prefix}",
                        style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (widget.roleUser == 1)
                  const SizedBox(
                    height: 20,
                  ),
                if (widget.roleUser == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ชื่อ-นามสกุล: ",
                        style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.firstName} ${widget.lastName}",
                        style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "อีเมล: ",
                      style: GoogleFonts.kanit(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      "${widget.email}",
                      style: GoogleFonts.kanit(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                widget.roleUser == 0
                    ? SizedBox(
                        height: 20,
                      )
                    : SizedBox(),
                widget.roleUser == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "รหัสนิสิต: ",
                            style: GoogleFonts.kanit(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "${widget.studentId}",
                            style: GoogleFonts.kanit(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                widget.roleUser == 0
                    ? SizedBox(
                        height: 20,
                      )
                    : SizedBox(),
                widget.roleUser == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "หลักสูตร: ",
                            style: GoogleFonts.kanit(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              "${widget.courseName}",
                              style: GoogleFonts.kanit(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                widget.roleUser == 0
                    ? SizedBox(
                        height: 20,
                      )
                    : SizedBox(),
                widget.roleUser == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ชั้นปี: ",
                            style: GoogleFonts.kanit(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              widget.studentId?.startsWith('64') == true
                                  ? "ปี 4"
                                  : widget.studentId?.startsWith('65') == true
                                      ? "ปี 3"
                                      : widget.studentId?.startsWith('66') ==
                                              true
                                          ? "ปี 2"
                                          : widget.studentId
                                                      ?.startsWith('67') ==
                                                  true
                                              ? "ปี 1"
                                              : "ไม่ทราบชั้นปี",
                              style: GoogleFonts.kanit(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
