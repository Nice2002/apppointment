import 'package:apppointment/Colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final String _baseUrl = 'https://appt-cis.smt-online.com/api';

  void _sendResetLink() async {
    final response = await http.post(
      Uri.parse('$_baseUrl/forgot-password'),
      body: {'email': _emailController.text},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset link sent')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending reset link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ลืมรหัสผ่าน",
          style: GoogleFonts.kanit(
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "คุณลืมรหัสผ่านใช่ไหม?",
              style: GoogleFonts.kanit(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "กรอกอีเมลของคุณเพื่อรีเซ็ตรหัสผ่าน",
              style: GoogleFonts.kanit(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(19, 0, 0, 0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกอีเมล';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color.fromARGB(137, 0, 102, 255),
                      width: 2.0,
                    ),
                  ),
                  hintText: "อีเมล",
                  hintStyle: TextStyle(
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  prefixIcon: Icon(Icons.email_outlined),
                  prefixIconColor: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: _sendResetLink,
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 116, 211),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "ส่งอีเมล",
                    style: GoogleFonts.kanit(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
