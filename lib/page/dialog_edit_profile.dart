import 'package:flutter/material.dart';

class Dialog_Edit_Profile extends StatefulWidget {
  const Dialog_Edit_Profile({super.key});

  @override
  State<Dialog_Edit_Profile> createState() => _Dialog_Edit_ProfileState();
}

class _Dialog_Edit_ProfileState extends State<Dialog_Edit_Profile> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 50,
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const Context()),
            // );
          },
          child: Container(
            height: 40,
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(Icons.image),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "เลือกรูปโปรไฟล์",
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
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
