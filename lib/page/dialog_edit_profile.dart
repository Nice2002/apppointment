import 'dart:io';
import 'dart:convert';
import 'package:apppointment/api/user_update_api.dart';
import 'package:apppointment/globals.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;
import 'package:flutter/material.dart';

class Dialog_Edit_Profile extends StatefulWidget {
  final int userId;
  const Dialog_Edit_Profile(this.userId, {Key? key}) : super(key: key);

  @override
  State<Dialog_Edit_Profile> createState() => _Dialog_Edit_ProfileState();
}

class _Dialog_Edit_ProfileState extends State<Dialog_Edit_Profile> {
  final _updateUser = GlobalKey<FormState>();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<UserUpdateModel> updateUser() async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://appt-cis.smt-online.com/api/user/update'),
    );
    request.headers['Authorization'] = 'Bearer $jwtToken';

    // Add text fields
    request.fields['id'] = widget.userId.toString();

    // Add image file
    if (_imageFile != null) {
      request.files.add(http.MultipartFile(
        'image_profile',
        _imageFile!.readAsBytes().asStream(),
        _imageFile!.lengthSync(),
        filename: 'image.png',
      ));
    }

    final response = await request.send();

    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseJson = await response.stream.bytesToString();
      final Map<String, dynamic> data = jsonDecode(responseJson);
      return UserUpdateModel.fromJson(data);
    } else {
      throw Exception('Failed to update data to the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _updateUser,
          child: Column(
            children: [
              InkWell(
                onTap: _pickImage,
                child: Container(
                  height: 40,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        SizedBox(width: 20),
                        Text(
                          "เลือกรูปโปรไฟล์",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_imageFile != null) // Show selected image
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(_imageFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.topSlide,
                    showCloseIcon: true,
                    title: "ยืนยันการเปลี่ยนรูปภาพ?",
                    desc: "คุณต้องการเปลี่ยนรูปภาพใช่หรือไม่?",
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      if (_imageFile == null) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "เลือกรูป",
                          btnOkOnPress: () {},
                        ).show();
                      } else {
                        if (_updateUser.currentState!.validate()) {}
                        UserUpdateModel res = await updateUser();
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "เปลี่ยนรูปภาพสำเร็จ",
                          btnOkOnPress: () {},
                        ).show();
                      }
                    },
                  ).show();
                },
                child: Text('อัปเดตโปรไฟล์'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
