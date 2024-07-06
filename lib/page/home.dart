import 'package:apppointment/api/appointments_api.dart';
import 'package:apppointment/api/appointments_count_api.dart';
import 'package:apppointment/api/user_api.dart';
import 'package:apppointment/page/notification.dart';
import 'package:apppointment/page/test.dart';
import 'package:apppointment/widget/donut2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class Homepage extends StatefulWidget implements PreferredSizeWidget {
  final int user_id;
  const Homepage(this.user_id, {Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomepageState extends State<Homepage> {
  late Future<UserModel> futureUser;
  late Future<AppointmentCountModel> futureAppointmentModel_1;
  late Future<AppointmentCountModel> futureAppointmentModel_2;
  late Future<AppointmentCountModel> futureAppointmentModel_3;

  @override
  void initState() {
    futureUser = fetchUser(widget.user_id);
    futureAppointmentModel_1 = fetchAppointmentModelStatusCount(1);
    futureAppointmentModel_2 = fetchAppointmentModelStatusCount(2);
    futureAppointmentModel_3 = fetchAppointmentModelStatusCount(3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: FutureBuilder<UserModel>(
                future: futureUser,
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (userSnapshot.hasError) {
                    return Center(
                        child: Text('เกิดข้อผิดพลาด: ${userSnapshot.error}'));
                  } else if (!userSnapshot.hasData) {
                    return Center(child: Text('ไม่มีข้อมูล'));
                  } else {
                    final user = userSnapshot.data!;
                    final String imageUrl =
                        'https://appt-cis.smt-online.com/api/public/${user.imageProfile}';

                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 70,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(255, 238, 237, 237),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    imageUrl,
                                    headers: {
                                      'Authorization':
                                          'Bearer ' + globals.jwtToken,
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 230,
                                      child: Text(
                                        "${user.prefix} ${user.firstName} ${user.lastName}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    user.roleUser == 0
                                        ? SizedBox(
                                            width: 230,
                                            child: Text(
                                              "นิสิตหลักสูตรสาขาวิชา${user.courseName}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 156, 156, 156)),
                                            ),
                                          )
                                        : SizedBox(
                                            width: 230,
                                            child: Text(
                                              "อาจารย์ภาควิชาวิทยาการคอมพิวเตอร์และสารสนเทศ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 156, 156, 156)),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const Notificationpage(),
                                  //   ),
                                  // );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Test(),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.notifications,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                child:
                                    Image.asset("assets/images/pie-chart.png"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "รายงานจำนวนการนัดหมาย",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 94, 170),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ประจำเดือนมกราคม พ.ศ.2567",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FutureBuilder<List<AppointmentCountModel>>(
                          future: Future.wait([
                            futureAppointmentModel_1,
                            futureAppointmentModel_2,
                            futureAppointmentModel_3,
                          ]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                            } else {
                              List<AppointmentCountModel> appointmentModels =
                                  snapshot.data!;

                              print(appointmentModels[0].count);
                              print(appointmentModels[1].count);
                              print(appointmentModels[2].count);

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            spreadRadius: 2.0,
                                            blurRadius: 2.0,
                                            offset: const Offset(0.0, 1.0),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'จำนวนครั้งรอวันนัดหมาย',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                '${appointmentModels[0].count}',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              Color.fromARGB(255, 0, 206, 171),
                                          width: 2,
                                        ),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            spreadRadius: 2.0,
                                            blurRadius: 2.0,
                                            offset: const Offset(0.0, 1.0),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'จำนวนครั้งนัดหมายสำเร็จ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                '${appointmentModels[1].count}',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Container(
                                          height: 70,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 187, 29, 18),
                                              width: 2,
                                            ),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                spreadRadius: 2.0,
                                                blurRadius: 2.0,
                                                offset: const Offset(0.0, 1.0),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 30, right: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'จำนวนครั้งนัดหมายถูกปฏิเสธ',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${appointmentModels[2].count}',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "รายงานจำนวนการนัดหมายทั้งหมดในระบบ",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 13, 187, 158),
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            spreadRadius: 2.0,
                                            blurRadius: 8.0,
                                            offset: const Offset(0.0, 1.0),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 30),
                                          DonutChart(
                                              appointmentModels[0].count,
                                              appointmentModels[1].count,
                                              appointmentModels[2].count),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            }
                          },
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
