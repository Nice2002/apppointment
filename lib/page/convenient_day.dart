import 'dart:convert';

import 'package:apppointment/api/convenient_day_insert_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class ConvenientDay extends StatefulWidget {
  final int user_id;
  const ConvenientDay(this.user_id, {Key? key}) : super(key: key);

  @override
  State<ConvenientDay> createState() => _ConvenientDayState();
}

class OpeningClosingTime {
  final List<String> days;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;

  OpeningClosingTime({
    required this.days,
    required this.openingTime,
    required this.closingTime,
  });
}

class _ConvenientDayState extends State<ConvenientDay> {
  late Future<ConvenientDayInsertModel> futureConvenientDayInsert;
  final _convenientDayform = GlobalKey<FormState>();
  final List<String> daysOfWeek = [
    'จันทร์',
    'อังคาร',
    'พุธ',
    'พฤหัสบดี',
    'ศุกร์'
  ];

  Map<String, TimeOfDay?> TimeStartControllers = {};
  Map<String, TimeOfDay?> TimeEndControllers = {};

  List<String> selectedDays = [];

  @override
  void initState() {
    for (var day in daysOfWeek) {
      TimeStartControllers[day] = TimeOfDay.now();
      TimeEndControllers[day] = TimeOfDay.now();
    }
    // futureConvenientDayInsert = fetchConvenientDayInsert(widget.user_id);
    super.initState();
  }

  Future<ConvenientDayInsertModel> fetchConvenientDayInsert() async {
    final user_id = widget.user_id;
    if (user_id == null) {
      throw Exception('User ID is null');
    }

    final url = 'https://appt-cis.smt-online.com/api/convenient/insert';

    List<Map<String, dynamic>> dayList = [];
    final materialLocalizations = MaterialLocalizations.of(context);

    selectedDays.forEach((dayThai) {
      int index = daysOfWeek.indexOf(dayThai);
      Map<String, dynamic> dayData = {
        'user_id': user_id.toString(),
        'day': (index + 1).toString(),
        'time_start': materialLocalizations
            .formatTimeOfDay(TimeStartControllers[dayThai]!),
        'time_end':
            materialLocalizations.formatTimeOfDay(TimeEndControllers[dayThai]!),
      };
      dayList.add(dayData);
    });

    final jsonData = jsonEncode({'convenients': dayList});

    final request = http.Request('POST', Uri.parse(url));
    request.headers['Content-Type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ' + globals.jwtToken;
    request.body = jsonData;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    // ข้อมูลสำหรับการดีบัก
    print('Response Status Code: ${response.statusCode}');
    print('Request Body: $jsonData');
    print('User ID: $user_id');
    print('Day List: $dayList');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isNotEmpty) {
        final responseData = json.decode(response.body);
        final contactInsertModel =
            ConvenientDayInsertModel.fromJson(responseData);
        return contactInsertModel;
      } else {
        throw Exception('Response body is empty');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ระบุวันเวลาที่สะดวก"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _convenientDayform,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: daysOfWeek.map((day) {
                    bool isOpen = selectedDays.contains(day);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Switch(
                              activeColor: Color.fromARGB(255, 11, 134, 0),
                              value: isOpen,
                              onChanged: (value) {
                                setState(() {
                                  if (value) {
                                    selectedDays.add(day);
                                  } else {
                                    selectedDays.remove(day);
                                  }
                                });
                              },
                            ),
                            Text(
                              day,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        if (isOpen)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      TimeOfDay? selectedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeStartControllers[day]!,
                                      );
                                      if (selectedTime != null) {
                                        setState(() {
                                          TimeStartControllers[day] =
                                              selectedTime;
                                        });
                                      }
                                    },
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: 'เวลาเริ่ม',
                                      ),
                                      child: Text(
                                        TimeStartControllers[day]!
                                            .format(context),
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      TimeOfDay? selectedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeEndControllers[day]!,
                                      );
                                      if (selectedTime != null) {
                                        setState(() {
                                          TimeEndControllers[day] =
                                              selectedTime;
                                        });
                                      }
                                    },
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: 'เวลาจบ',
                                      ),
                                      child: Text(
                                        TimeEndControllers[day]!
                                            .format(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
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
                  if (_convenientDayform.currentState!.validate()) {
                    ConvenientDayInsertModel res =
                        await fetchConvenientDayInsert();
                  }
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
        ),
      ],
    );
  }
}
