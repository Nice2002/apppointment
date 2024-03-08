import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  bool _isWeekend(DateTime day) {
    return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
  }

  DateTime today = DateTime.now();
  String name = 'เลือก';
  String strattime = 'เลือก';
  String fistime = 'เลือก';
  String business = 'เลือก';
  int title = -1;
  void _titleCheckboxChanged(int index) {
    setState(() {
      if (title == index) {
        title = -1;
      } else {
        title = index;
      }
    });
  }

  int room = -1;
  void _roomCheckboxChanged(int index) {
    setState(() {
      if (room == index) {
        room = -1;
      } else {
        room = index;
      }
    });
  }

  int status = -1;
  void _statusCheckboxChanged(int index) {
    setState(() {
      if (status == index) {
        status = -1;
      } else {
        status = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black, // สีของเงา
        title: const Text('เพิ่มข้อมูลการนัดหมาย'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3.0,
                  blurRadius: 5.0,
                  offset: const Offset(0.0, 1.0), // changes position of shadow
                ),
              ],
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'เลือกหลักสูตรของนิสิต',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 13, 187, 158),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2.0,
                                blurRadius: 8.0,
                                offset: const Offset(0.0, 1.0),
                              ),
                            ],
                          ),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: DropdownButton<String>(
                                value: fistime,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                ),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: GoogleFonts.prompt().fontFamily,
                                ),
                                underline: Container(
                                  height: 0,
                                  color: Colors.transparent,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    fistime = newValue ?? 'เลือก';
                                  });
                                },
                                items: <String>[
                                  'เลือก',
                                  'หลักสูตรวิทยาการคอมพิวเตอร์',
                                  'หลักสูตรวิทยาการข้อมูล',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'เลือกนิสิตที่ต้องการเข้าพบ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  AutocompleteBasicExample(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'เรื่องที่ต้องการนัดหมาย',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Container(
                    height: 45,
                    child: CheckboxListTile(
                      value: title == 0,
                      onChanged: (value) {
                        _titleCheckboxChanged(0);
                      },
                      title: Text('โครงงาน'),
                    ),
                  ),
                  Container(
                    height: 45,
                    child: CheckboxListTile(
                      value: title == 1,
                      onChanged: (value) {
                        _titleCheckboxChanged(1);
                      },
                      title: Text('งานกิจกรรม'),
                    ),
                  ),
                  Container(
                    height: 45,
                    child: CheckboxListTile(
                      value: title == 2,
                      onChanged: (value) {
                        _titleCheckboxChanged(2);
                      },
                      title: Text('อื่นๆ'),
                    ),
                  ),
                  if (title == 2)
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 13, 187, 158),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1.0,
                            blurRadius: 3.0,
                            offset: const Offset(0.0, 1.0),
                          ),
                        ],
                      ),
                      child: Theme(
                        data: ThemeData(
                          inputDecorationTheme: InputDecorationTheme(
                            border: InputBorder.none,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'กรอกเรื่อง',
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                fontFamily: GoogleFonts.prompt().fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'รายละเอียดการนัดหมาย',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 13, 187, 158),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1.0,
                          blurRadius: 3.0,
                          offset: const Offset(0.0, 1.0),
                        ),
                      ],
                    ),
                    child: Theme(
                      data: ThemeData(
                        inputDecorationTheme: InputDecorationTheme(
                          border: InputBorder.none,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          maxLines: 6,
                          maxLength: 150,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(150)
                          ],
                          decoration: InputDecoration(
                            hintText: 'กรอกรายละเอียดของเรื่อง',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              fontFamily: GoogleFonts.prompt().fontFamily,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      // const Icon(
                      //   Icons.calendar_month,
                      //   size: 25,
                      // ),
                      // const SizedBox(
                      //   width: 3,
                      // ),
                      Text(
                        'เลือกวันที่ต้องการนัดหมาย',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(255, 13, 187, 158)),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2.0,
                          blurRadius: 5.0,
                          offset: const Offset(0.0, 1.0),
                        ),
                      ],
                    ),
                    child: TableCalendar<String>(
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      rowHeight: 45,
                      availableGestures: AvailableGestures.all,
                      focusedDay: today,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      selectedDayPredicate: (day) => isSameDay(day, today),
                      calendarStyle:
                          const CalendarStyle(outsideDaysVisible: false),
                      onDaySelected: _onDaySelected,
                      enabledDayPredicate: (day) => !_isWeekend(day),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      // const Icon(
                      //   Icons.watch_later,
                      //   size: 25,
                      // ),
                      // const SizedBox(
                      //   width: 3,
                      // ),
                      Text(
                        'ช่วงเวลา',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 13, 187, 158)),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2.0,
                              blurRadius: 8.0,
                              offset: const Offset(0.0, 1.0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: DropdownButton<String>(
                              value: strattime,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                size: 30,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: GoogleFonts.prompt().fontFamily,
                              ),
                              underline: Container(
                                height: 0,
                                color: Colors.transparent,
                              ),
                              onChanged: (String? newValue) {
                                setState(
                                  () {
                                    strattime = newValue ??
                                        'เลือก'; // Handle null values
                                  },
                                );
                              },
                              items: <String>[
                                'เลือก',
                                '09.00',
                                '09.30',
                                '10.00',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        value,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'ถึง',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 13, 187, 158),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2.0,
                              blurRadius: 8.0,
                              offset: const Offset(0.0, 1.0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: DropdownButton<String>(
                              value: fistime,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                size: 30,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: GoogleFonts.prompt().fontFamily,
                              ),
                              underline: Container(
                                height: 0,
                                color: Colors.transparent,
                              ),
                              onChanged: (String? newValue) {
                                setState(
                                  () {
                                    fistime = newValue ??
                                        'เลือก'; // Handle null values
                                  },
                                );
                              },
                              items: <String>[
                                'เลือก',
                                '10.00',
                                '10.30',
                                '11.00',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        value,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ห้อง',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 45,
                    child: CheckboxListTile(
                      value: room == 0,
                      onChanged: (value) {
                        _roomCheckboxChanged(0);
                      },
                      title: Text('ห้องพักอาจารย์'),
                    ),
                  ),
                  Container(
                    height: 45,
                    child: CheckboxListTile(
                      value: room == 1,
                      onChanged: (value) {
                        _roomCheckboxChanged(1);
                      },
                      title: Text('อื่นๆ'),
                    ),
                  ),
                  if (room == 1)
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 13, 187, 158),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1.0,
                            blurRadius: 3.0,
                            offset: const Offset(0.0, 1.0),
                          ),
                        ],
                      ),
                      child: Theme(
                        data: ThemeData(
                          inputDecorationTheme: InputDecorationTheme(
                            border: InputBorder.none,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'กรอกห้องที่สะดวก',
                              hintStyle: TextStyle(
                                fontSize: 16.0,
                                fontFamily: GoogleFonts.prompt().fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'สถานะ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 45,
                    child: CheckboxListTile(
                      value: status == 0,
                      onChanged: (value) {
                        _statusCheckboxChanged(0);
                      },
                      title: Text('ปกติ'),
                    ),
                  ),
                  Container(
                    height: 45,
                    child: CheckboxListTile(
                      value: status == 1,
                      onChanged: (value) {
                        _statusCheckboxChanged(1);
                      },
                      title: Text('เร่งด่วน'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      width: 375,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 13, 187, 158),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ChangePassword()));
                          AwesomeNotifications().createNotification(
                            content: NotificationContent(
                              id: 3,
                              channelKey: "basic_channel",
                              title: "Notification test",
                              body: "Notification test",
                              color: Colors.deepPurple,
                            ),
                          );
                        },
                        child: const Center(
                          child: Text(
                            "เพิ่มข้อมูลนัดหมาย",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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

class AutocompleteBasicExample extends StatefulWidget {
  const AutocompleteBasicExample({Key? key}) : super(key: key);

  static const List<String> _kOptions = <String>[
    'สาวิณี แสงสุริยันต์',
    'ฐาปนี เฮงสนั่นกูล',
    'ศิริพร แสนศรี',
    'พีระ ลิ่วลม',
    'สุภาพ กัญญาคำ',
    'จักรนรินทร์ คงเจริญ',
    'วไลลักษณ์ วงษ์รื่น',
    'ศศิธร สุชัยยะ',
    'ถนอมศักดิ์ วงศ์มีแก้ว',
    'อัจฉรา นามบุรี',
    'สุรศักดิ์ ตั้งสกุล',
    'จิตสราญ สีกู่กา',
    'จารุวัฒน์ ไพใหล',
    'บวรรัตน์ ศรีมาน',
  ];

  @override
  _AutocompleteBasicExampleState createState() =>
      _AutocompleteBasicExampleState();
}

class _AutocompleteBasicExampleState extends State<AutocompleteBasicExample> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return AutocompleteBasicExample._kOptions.where((String option) =>
            option.contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        _textEditingController = fieldTextEditingController;
        return Container(
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 13, 187, 158),
            ),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
                spreadRadius: 2.0,
                blurRadius: 8.0,
                offset: const Offset(0.0, 1.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _textEditingController,
              focusNode: fieldFocusNode,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'ค้นหาชื่อนิสิต'),
              onSubmitted: (String value) {
                onFieldSubmitted();
              },
            ),
          ),
        );
      },
    );
  }
}
