import 'package:flutter/material.dart';

class Convenient extends StatefulWidget {
  const Convenient({super.key});

  @override
  State<Convenient> createState() => _ConvenientState();
}

class _ConvenientState extends State<Convenient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('วันเวลาที่สะดวก'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'วันจันทร์',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'กรอกเวลา', // ข้อความในช่องกรอกข้อมูล
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('ถึง'),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'กรอกเวลา', // ข้อความในช่องกรอกข้อมูล
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'วันอังคาร',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'กรอกเวลา', // ข้อความในช่องกรอกข้อมูล
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('ถึง'),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'กรอกเวลา', // ข้อความในช่องกรอกข้อมูล
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'วันพุธ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'กรอกเวลา', // ข้อความในช่องกรอกข้อมูล
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('ถึง'),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'กรอกเวลา', // ข้อความในช่องกรอกข้อมูล
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'วันพฤหัสบดี',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'กรอกเวลา', // ข้อความในช่องกรอกข้อมูล
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('ถึง'),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'กรอกเวลา', // ข้อความในช่องกรอกข้อมูล
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'วันศุกร์',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'กรอกเวลา', // ข้อความในช่องกรอกข้อมูล
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('ถึง'),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'กรอกเวลา', // ข้อความในช่องกรอกข้อมูล
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
