import 'dart:convert';

import 'package:apppointment/api/convenient_day_insert_api.dart';
import 'package:apppointment/api/convrnirnt_day_api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class ConvenientDay extends StatefulWidget {
  final int user_id;
  const ConvenientDay(this.user_id, {Key? key}) : super(key: key);

  @override
  State<ConvenientDay> createState() => _ConvenientDayState();
}

class _ConvenientDayState extends State<ConvenientDay> {
  late Future<List<ConvenientDayModel>> futureConvenientDay;
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
    super.initState();

    for (var day in daysOfWeek) {
      TimeStartControllers[day] = TimeOfDay.now();
      TimeEndControllers[day] = TimeOfDay.now();
    }

    futureConvenientDay = fetchConvenientDay(widget.user_id);
    futureConvenientDayInsert = fetchConvenientDayInsert();
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

  Future<ConvenientDayInsertModel> fetchConvenientDayUpdate() async {
    final user_id = widget.user_id;
    if (user_id == null) {
      throw Exception('User ID is null');
    }

    final url =
        'https://appt-cis.smt-online.com/api/convenient/update/$user_id';

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
        title: Text(
          "ระบุวันเวลาที่สะดวก",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _convenientDayform,
          child: FutureBuilder<List<ConvenientDayModel>>(
              future: futureConvenientDay,
              builder: (context, convenientSnapshot) {
                if (convenientSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (convenientSnapshot.hasError) {
                  return Center(
                    child: Text('เกิดข้อผิดพลาด: ${convenientSnapshot.error}'),
                  );
                }
                final List<ConvenientDayModel> convenientDays =
                    convenientSnapshot.data!;
                List<ConvenientDayModel> sortedDays = List.from(convenientDays)
                  ..sort((a, b) => a.day.compareTo(b.day));

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "ข้อมูลวัน เวลาที่สะดวก",
                        style: GoogleFonts.kanit(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: sortedDays.map((day) {
                          String dayName;
                          switch (day.day) {
                            case 1:
                              dayName = 'จันทร์';
                              break;
                            case 2:
                              dayName = 'อังคาร';
                              break;
                            case 3:
                              dayName = 'พุธ';
                              break;
                            case 4:
                              dayName = 'พฤหัสบดี';
                              break;
                            case 5:
                              dayName = 'ศุกร์';
                              break;
                            default:
                              dayName = 'Unknown';
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "วัน: $dayName",
                                style: GoogleFonts.kanit(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                  "เวลา ${day.timeStart} น. ถึง เวลา ${day.timeEnd} "),
                              Divider(),
                            ],
                          );

                          // Text(
                          //   'วัน: $dayName, เวลา: ${day.timeStart} - เวลา: ${day.timeEnd}',
                          //   style: TextStyle(fontSize: 16),
                          // );
                        }).toList(),
                      ),
                    ),
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
                                    activeColor:
                                        Color.fromARGB(255, 11, 134, 0),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            TimeOfDay? selectedTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeStartControllers[day]!,
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
                                                  fontSize: 14,
                                                  color: Colors.black),
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
                                              initialTime:
                                                  TimeEndControllers[day]!,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 116, 211),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () async {
                              if (_convenientDayform.currentState!.validate()) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.question,
                                  animType: AnimType.topSlide,
                                  showCloseIcon: true,
                                  title: "ยืนยันการเพิ่มช่องทางการติดต่อ?",
                                  desc:
                                      "คุณต้องการเพิ่มช่องทางการติดต่อใช่หรือไม่?",
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () async {
                                    if (convenientDays.isNotEmpty) {
                                      ConvenientDayInsertModel res =
                                          await fetchConvenientDayUpdate();
                                    } else {
                                      ConvenientDayInsertModel res =
                                          await fetchConvenientDayInsert();
                                    }
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.topSlide,
                                      showCloseIcon: true,
                                      title: "เพิ่มช่องทางการติดต่อสำเร็จ",
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
                              // if (_convenientDayform.currentState!.validate()) {
                              //   ConvenientDayInsertModel res =
                              //       await fetchConvenientDayUpdate();
                              //   // Handle the response if needed
                              // }
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
                    SizedBox(height: 15),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
