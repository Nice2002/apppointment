import 'dart:convert';
import 'package:apppointment/Colors/app_color.dart';
import 'package:apppointment/api/contact_api.dart';
import 'package:apppointment/api/contact_insert_api.dart';
import 'package:apppointment/api/contact_update_api.dart';
import 'package:apppointment/page/profile.dart';
import 'package:apppointment/page/profile_2.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class Contact extends StatefulWidget {
  final int? user_id;
  final String? email;
  const Contact(this.user_id, this.email, {Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContextState();
}

class _ContextState extends State<Contact> {
  late Future<ContactModel?> futureContact;

  final _contactform = GlobalKey<FormState>();
  final lineController = TextEditingController();
  final phone_numberController = TextEditingController();
  final facebookController = TextEditingController();

  @override
  void initState() {
    if (widget.user_id == null) {
      print("not user id");
    } else {
      futureContact = fetchContact(widget.user_id);
    }

    super.initState();
  }

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
  void dispose() {
    super.dispose();
    lineController.dispose();
    phone_numberController.dispose();
    facebookController.dispose();
  }

  Future<ContactInsertModel> fetchContactInsert() async {
    final String user_id = widget.user_id.toString();
    final String line = lineController.text;
    final String phone_number = phone_numberController.text;
    final String facebook = facebookController.text;

    final request = http.MultipartRequest('POST',
        Uri.parse('https://appt-cis.smt-online.com/api/contact/insert'));

    request.headers['Authorization'] = 'Bearer ' + globals.jwtToken;
    request.fields['user_id'] = user_id;
    request.fields['line'] = line;
    request.fields['phone_number'] = phone_number;
    request.fields['facebook'] = facebook;

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    // Debugging information
    // print('user_id: $user_id');
    // print('line: $line');
    // print('phone_number: $phone_number');
    // print('facebook: $facebook');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: $responseData');

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final jsonResponse = json.decode(responseData);
        final contactInsertModel = ContactInsertModel.fromJson(jsonResponse);
        return contactInsertModel;
      } catch (e) {
        throw Exception('Failed to parse response as JSON: $e');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<ContactUpdateModel> fetchContactUpdate(int? contact) async {
    final contact_id = contact;
    final line = lineController.text;
    final phone_number = phone_numberController.text;
    final facebook = facebookController.text;

    final url = Uri.parse('https://appt-cis.smt-online.com/api/contact/update');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + globals.jwtToken
    };

    print("contact_id :${contact_id}");

    final body = jsonEncode(
      {
        'id': contact_id,
        'line': line,
        'phone_number': phone_number,
        'facebook': facebook,
      },
    );

    final response = await http.post(url, headers: headers, body: body);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final fetchContactUpdate =
          ContactUpdateModel.fromJson(json.decode(response.body));
      print('Appointment Reject Model: $fetchContactUpdate');
      return fetchContactUpdate;
    } else {
      print(
          'Failed to Reject appointment. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to Reject appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ช่องทางการติดต่อ'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<ContactModel?>(
          future: futureContact,
          builder: (context, contactSnapshot) {
            if (contactSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (contactSnapshot.hasError) {
              return Center(
                  child: Text('เกิดข้อผิดพลาด: ${contactSnapshot.error}'));
            } else if (!contactSnapshot.hasData) {
              return Center(child: Text('ไม่มีข้อมูล'));
            } else {
              final contact = contactSnapshot.data!;

              lineController.text = contact.line ?? '';
              if (contact.line != null) {
                lineController.text = contact.line!;
              } else {
                lineController.text = '';
              }
              phone_numberController.text = contact.phoneNumber ?? '';
              if (contact.phoneNumber != null) {
                phone_numberController.text = contact.phoneNumber!;
              } else {
                phone_numberController.text = '';
              }
              facebookController.text = contact.facebook ?? '';
              if (contact.facebook != null) {
                facebookController.text = contact.facebook!;
              } else {
                facebookController.text = '';
              }
              return Form(
                key: _contactform,
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
                          'เพิ่มช่องทางการติดต่อเพื่อแสดงในข้อมูลการนัดหมาย',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   height: 45,
                            //   child: CheckboxListTile(
                            //     value: selectedContexts.contains(0),
                            //     onChanged: (value) {
                            //       _contextsCheckboxChanged(0);
                            //     },
                            //     title: Text('อีเมล :'),
                            //   ),
                            // ),
                            // Text(
                            //   "อีเมล : ",
                            //   style: GoogleFonts.kanit(
                            //     textStyle: const TextStyle(
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.w400,
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 20),
                            //   child: Text(
                            //     '${widget.email}',
                            //     style: GoogleFonts.kanit(
                            //       textStyle: const TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w400,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   height: 45,
                            //   child: CheckboxListTile(
                            //     value: selectedContexts.contains(1),
                            //     onChanged: (value) {
                            //       // if (contact.line != null) {
                            //       _contextsCheckboxChanged(1);
                            //       // }
                            //     },
                            //     title: Text('ไอดีไลน์ :'),
                            //   ),
                            // ),
                            // if (selectedContexts.contains(1))
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "ไอดีไลน์ : ",
                              style: GoogleFonts.kanit(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(19, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                controller: lineController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(137, 0, 102, 255),
                                      width: 2.0,
                                    ),
                                  ),
                                  hintText: "เพิ่มไอดีไลน์",
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
                            //   height: 45,
                            //   child: CheckboxListTile(
                            //     value: selectedContexts.contains(2),
                            //     onChanged: (value) {
                            //       _contextsCheckboxChanged(2);
                            //     },
                            //     title: Text('เบอร์โทรศัพท์ :'),
                            //   ),
                            // ),
                            // if (selectedContexts.contains(2))
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "เบอร์โทรศัพท์ : ",
                              style: GoogleFonts.kanit(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(19, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                controller: phone_numberController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(137, 0, 102, 255),
                                      width: 2.0,
                                    ),
                                  ),
                                  hintText: "เพิ่มเบอร์โทรศัพท์",
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
                            //   height: 45,
                            //   child: CheckboxListTile(
                            //     value: selectedContexts.contains(3),
                            //     onChanged: (value) {
                            //       _contextsCheckboxChanged(3);
                            //     },
                            //     title: Text('ชื่อเฟซบุ๊ก :'),
                            //   ),
                            // ),
                            // if (contact.facebook != null)
                            //   Padding(
                            //     padding: const EdgeInsets.only(left: 20),
                            //     child: Text(
                            //       "${contact.facebook}",
                            //     ),
                            //   ),
                            // if (selectedContexts.contains(3))
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "ชื่อเฟซบุ๊ก : ",
                              style: GoogleFonts.kanit(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(19, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                controller: facebookController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(137, 0, 102, 255),
                                      width: 2.0,
                                    ),
                                  ),
                                  hintText: "เพิ่มไชื่อเฟซบุ๊ก",
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
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 116, 211),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    if (_contactform.currentState!.validate()) {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.question,
                                        animType: AnimType.topSlide,
                                        showCloseIcon: true,
                                        title:
                                            "ยืนยันการเพิ่มช่องทางการติดต่อ?",
                                        desc:
                                            "คุณต้องการเพิ่มช่องทางการติดต่อใช่หรือไม่?",
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () async {
                                          if (contact.contact_id != null) {
                                            ContactUpdateModel res =
                                                await fetchContactUpdate(
                                                    contact.contact_id);
                                            print(contact.contact_id);
                                          } else {
                                            ContactInsertModel res =
                                                await fetchContactInsert();
                                          }
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.topSlide,
                                            showCloseIcon: true,
                                            title:
                                                "เพิ่มช่องทางการติดต่อสำเร็จ",
                                            btnOkOnPress: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             ProfileScreen()));
                                            },
                                          ).show();
                                        },
                                      ).show();
                                    }
                                    // if (_contactform.currentState!.validate()) {
                                    //   if (contact.contact_id != null) {
                                    //     ContactUpdateModel res =
                                    //         await fetchContactUpdate(
                                    //             contact.contact_id);
                                    //     print(contact.contact_id);
                                    //   } else {
                                    //     ContactInsertModel res =
                                    //         await fetchContactInsert();
                                    //   }
                                    // }
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
                          ],
                        ),
                      ],
                    ),
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
