import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class Add_Aj extends StatefulWidget {
  const Add_Aj({super.key});

  @override
  State<Add_Aj> createState() => _Add_AjState();
}

class _Add_AjState extends State<Add_Aj> {
  DateTime today = DateTime.now();
  Map<DateTime, List<String>> _events = {};
  late final ValueNotifier<List<String>> _selectedEvents;
  String strattime = 'เลือก';
  String fistime = 'เลือก';
  String business = 'เลือก';
  String room = 'เลือก';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 1,
        title: const Text('เพิ่มข้อมูลการนัดหมาย'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'เลือกนิสิตที่ต้องการพบ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              AutocompleteBasicExample(),
              const SizedBox(
                height: 20,
              ),
              Text(
                'กรอกเรื่องที่ต้องการนัดหมาย',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
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
                height: 10,
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
                        hintText: 'กรอกรายละเอียด',
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
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: const Color.fromARGB(
                          255, 13, 187, 158)), // กำหนดสีขอบ
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
                  selectedDayPredicate: (day) => isSameDay(day, today),
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
              Row(
                children: [
                  // const Icon(
                  //   Icons.business,
                  //   size: 25,
                  // ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  Text(
                    'อาคาร',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 140),
                    child: Text(
                      'ห้อง',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.5),
                      ),
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
                          value: business,
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
                                business =
                                    newValue ?? 'เลือก'; // Handle null values
                              },
                            );
                          },
                          items: <String>[
                            'เลือก',
                            '7',
                            '8',
                            '9',
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
                          value: room,
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
                                room =
                                    newValue ?? 'เลือก'; // Handle null values
                              },
                            );
                          },
                          items: <String>[
                            'เลือก',
                            '114/1',
                            '114/2',
                            '114/3',
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
                          title: "แจ้งเตือนคำขอนัดหมาย",
                          body: "ในวันที่ 16 มกราคม 2567 เวลา 11.00-12.30 น.",
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
                  border: InputBorder.none, hintText: 'ค้นหาชื่อหรือรหัสนิสิต'),
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
