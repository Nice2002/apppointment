import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  DateTime today = DateTime.now();
  Map<DateTime, List<String>> _events = {};
  late final ValueNotifier<List<String>> _selectedEvents;
  String name = 'เลือก';
  String strattime = 'เลือก';
  String fistime = 'เลือก';
  String business = 'เลือก';
  int title = -1;
  void _titleCheckboxChanged(int index) {
    setState(() {
      if (title == index) {
        // Uncheck the checkbox if it's already checked
        title = -1;
      } else {
        // Check the checkbox and uncheck the previously checked one
        title = index;
      }
    });
  }

  int room = -1;
  void _roomCheckboxChanged(int index) {
    setState(() {
      if (room == index) {
        // Uncheck the checkbox if it's already checked
        room = -1;
      } else {
        // Check the checkbox and uncheck the previously checked one
        room = index;
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
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     // Icon(
              //     //   Icons.person,
              //     //   size: 35,
              //     // ),
              //     // SizedBox(
              //     //   width: 3,
              //     // ),
              //     Text(
              //       'เลือกหลักสูตรของอาจารย์',
              //       style: TextStyle(
              //         fontSize: 18,
              //         color: Colors.black.withOpacity(0.5),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Container(
              //   height: 55,
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: const Color.fromARGB(255, 13, 187, 158),
              //     ),
              //     borderRadius: BorderRadius.circular(10.0),
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.1),
              //         spreadRadius: 2.0,
              //         blurRadius: 8.0,
              //         offset: const Offset(0.0, 1.0),
              //       ),
              //     ],
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10),
              //     child: Align(
              //       alignment: Alignment.center,
              //       child: DropdownButton<String>(
              //         value: name,
              //         icon: const Icon(
              //           Icons.arrow_drop_down,
              //           size: 30,
              //         ),
              //         iconSize: 24,
              //         elevation: 16,
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontFamily: GoogleFonts.prompt().fontFamily,
              //         ),
              //         underline: Container(
              //           height: 0,
              //           color: Colors.transparent,
              //         ),
              //         onChanged: (String? newValue) {
              //           setState(
              //             () {
              //               name = newValue ?? 'เลือก'; // Handle null values
              //             },
              //           );
              //         },
              //         items: <String>[
              //           'เลือก',
              //           'อาจารย์ อัจฉรา นามบุรี',
              //           'อาจารย์ สมศักดิ์ ใจดี',
              //           'อาจารย์ วิทยา ความรู้'
              //         ].map<DropdownMenuItem<String>>((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: Container(
              //               width: 290,
              //               child: Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text(
              //                   value,
              //                   style: const TextStyle(fontSize: 18),
              //                 ),
              //               ),
              //             ),
              //           );
              //         }).toList(),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              Row(
                children: [
                  // Icon(
                  //   Icons.person,
                  //   size: 35,
                  // ),
                  // SizedBox(
                  //   width: 3,
                  // ),
                  Text(
                    'เลือกอาจารย์ที่ต้องการเข้าพบ',
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
              // Container(
              //   height: 55,
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: const Color.fromARGB(255, 13, 187, 158),
              //     ),
              //     borderRadius: BorderRadius.circular(10.0),
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.1),
              //         spreadRadius: 2.0,
              //         blurRadius: 8.0,
              //         offset: const Offset(0.0, 1.0),
              //       ),
              //     ],
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10),
              //     child: Align(
              //       alignment: Alignment.center,
              //       child: DropdownButton<String>(
              //         value: name,
              //         icon: const Icon(
              //           Icons.arrow_drop_down,
              //           size: 30,
              //         ),
              //         iconSize: 24,
              //         elevation: 16,
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontFamily: GoogleFonts.prompt().fontFamily,
              //         ),
              //         underline: Container(
              //           height: 0,
              //           color: Colors.transparent,
              //         ),
              //         onChanged: (String? newValue) {
              //           setState(
              //             () {
              //               name = newValue ?? 'เลือก'; // Handle null values
              //             },
              //           );
              //         },
              //         items: <String>[
              //           'เลือก',
              //           'อาจารย์ อัจฉรา นามบุรี',
              //           'อาจารย์ สมศักดิ์ ใจดี',
              //           'อาจารย์ วิทยา ความรู้'
              //         ].map<DropdownMenuItem<String>>((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: Container(
              //               width: 290,
              //               child: Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text(
              //                   value,
              //                   style: const TextStyle(fontSize: 18),
              //                 ),
              //               ),
              //             ),
              //           );
              //         }).toList(),
              //       ),
              //     ),
              //   ),
              // ),
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

              CheckboxListTile(
                value: title == 0,
                onChanged: (value) {
                  _titleCheckboxChanged(0);
                },
                title: Text('โครงงาน'),
              ),
              CheckboxListTile(
                value: title == 1,
                onChanged: (value) {
                  _titleCheckboxChanged(1);
                },
                title: Text('งานกิจกรรม'),
              ),
              CheckboxListTile(
                value: title == 2,
                onChanged: (value) {
                  _titleCheckboxChanged(2);
                },
                title: Text('อื่นๆ'),
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
              // Container(
              //   height: 55,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(
              //       color: const Color.fromARGB(255, 13, 187, 158),
              //     ),
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.1),
              //         spreadRadius: 1.0,
              //         blurRadius: 3.0,
              //         offset: const Offset(0.0, 1.0),
              //       ),
              //     ],
              //   ),
              //   child: Theme(
              //     data: ThemeData(
              //       inputDecorationTheme: InputDecorationTheme(
              //         border: InputBorder.none,
              //       ),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 15),
              //       child: TextFormField(
              //         decoration: InputDecoration(
              //           hintText: 'กรอกเรื่อง',
              //           hintStyle: TextStyle(
              //             fontSize: 16.0,
              //             fontFamily: GoogleFonts.prompt().fontFamily,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 170,
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
                      inputFormatters: [LengthLimitingTextInputFormatter(150)],
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
                    color: const Color.fromARGB(255, 13, 187, 158),
                  ), // กำหนดสีขอบ
                  borderRadius: BorderRadius.circular(10.0), // กำหนดรูปร่างขอบ
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2.0,
                      blurRadius: 5.0,
                      offset:
                          const Offset(0.0, 1.0), // changes position of shadow
                    ),
                  ],
                ),
                child: TableCalendar<String>(
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  rowHeight: 40,
                  availableGestures: AvailableGestures.all,
                  focusedDay: today,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  selectedDayPredicate: (day) {
                    final today = DateTime.now();
                    return !day.isBefore(today) &&
                        !day.isAfter(today) &&
                        ![DateTime.saturday, DateTime.sunday]
                            .contains(day.weekday);
                  },
                  onDaySelected: _onDaySelected,
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: TextStyle(
                      color: Colors.blue,
                    ),
                    defaultTextStyle: TextStyle(
                      color: Colors.black,
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
                  const SizedBox(
                    width: 80,
                  ),
                  // Text(
                  //   'ทั้งวัน',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  // SwitcherButton(
                  //   onColor: Colors.white,
                  //   offColor: Color.fromARGB(255, 13, 187, 158),
                  //   value: true,
                  //   onChange: (value) {
                  //     print(value);
                  //   },
                  // ),
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
                                strattime =
                                    newValue ?? 'เลือก'; // Handle null values
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
                                width: 105,
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
                                fistime =
                                    newValue ?? 'เลือก'; // Handle null values
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
                                width: 105,
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
                height: 10,
              ),
              CheckboxListTile(
                value: room == 0,
                onChanged: (value) {
                  _roomCheckboxChanged(0);
                },
                title: Text('ห้องพักอาจารย์'),
              ),
              CheckboxListTile(
                value: room == 1,
                onChanged: (value) {
                  _roomCheckboxChanged(1);
                },
                title: Text('อื่นๆ'),
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
              // Row(
              //   children: [
              //     Container(
              //       height: 55,
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: const Color.fromARGB(255, 13, 187, 158),
              //         ),
              //         borderRadius: BorderRadius.circular(10.0),
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey.withOpacity(0.1),
              //             spreadRadius: 2.0,
              //             blurRadius: 8.0,
              //             offset: const Offset(0.0, 1.0),
              //           ),
              //         ],
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 10),
              //         child: Align(
              //           alignment: Alignment.center,
              //           child: DropdownButton<String>(
              //             value: room,
              //             icon: const Icon(
              //               Icons.arrow_drop_down,
              //               size: 30,
              //             ),
              //             iconSize: 24,
              //             elevation: 16,
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontFamily: GoogleFonts.prompt().fontFamily,
              //             ),
              //             underline: Container(
              //               height: 0,
              //               color: Colors.transparent,
              //             ),
              //             onChanged: (String? newValue) {
              //               setState(
              //                 () {
              //                   room =
              //                       newValue ?? 'เลือก'; // Handle null values
              //                 },
              //               );
              //             },
              //             items: <String>[
              //               'เลือก',
              //               '114/1',
              //               '114/2',
              //               '114/3',
              //             ].map<DropdownMenuItem<String>>((String value) {
              //               return DropdownMenuItem<String>(
              //                 value: value,
              //                 child: Container(
              //                   width: 105,
              //                   height: 40,
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Text(
              //                       value,
              //                       style: const TextStyle(fontSize: 18),
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             }).toList(),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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
                            fontSize: 20,
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
    );
  }
}

class AutocompleteBasicExample extends StatefulWidget {
  const AutocompleteBasicExample({Key? key}) : super(key: key);

  static const List<String> _kOptions = <String>[
    'ธรรมนูญ เหมือนสิงห์',
    'ปิติภัทร มะลิทอง',
    'อดิเทพ ศรีบุญเรือง',
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
            padding: const EdgeInsets.only(left: 20),
            child: TextField(
              controller: _textEditingController,
              focusNode: fieldFocusNode,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'ค้นหาชื่ออาจารย์'),
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
