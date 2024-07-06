import 'package:apppointment/Colors/app_color.dart';
import 'package:apppointment/page/add.dart';
import 'package:apppointment/page/calendar.dart';
import 'package:apppointment/page/calendarpage.dart';
import 'package:apppointment/page/home_2.dart';
import 'package:apppointment/page/message.dart';
import 'package:apppointment/page/profile.dart';
import 'package:apppointment/page/profile_2.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';

class BottomNavigatorScreen extends StatefulWidget {
  final int user_id;
  final int IndexPage;
  final int roleUser;
  final String prefix;
  final String firstName;
  final String lastName;
  const BottomNavigatorScreen(
      {super.key,
      required this.user_id,
      required this.IndexPage,
      required this.roleUser,
      required this.prefix,
      required this.firstName,
      required this.lastName});

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorScreenState();
}

class _BottomNavigatorScreenState extends State<BottomNavigatorScreen> {
  late int IndexPage;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    IndexPage = widget.IndexPage;
    _widgetOptions = [
      HomeScreen(
          widget.user_id, widget.prefix, widget.firstName, widget.lastName),
      // Calendarpage(widget.user_id),
      CalendarScreen(widget.user_id),
      Message(widget.user_id),
      ProfileScreen(
          widget.user_id, widget.prefix, widget.firstName, widget.lastName),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[IndexPage],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Add(widget.user_id, widget.roleUser)));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        elevation: 10,
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        animationDuration: const Duration(seconds: 1),
        indicatorColor: const Color.fromARGB(0, 255, 255, 255),
        surfaceTintColor: Colors.white,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              EneftyIcons.home_3_outline,
              size: 30,
              color: AppColors.primaryColor,
            ),
            selectedIcon: Icon(
              EneftyIcons.home_3_bold,
              size: 30,
              color: AppColors.primaryColor,
            ),
            label: "หน้าแรก",
          ),
          NavigationDestination(
            icon: Icon(
              EneftyIcons.calendar_2_outline,
              size: 30,
              color: AppColors.primaryColor,
            ),
            selectedIcon: Icon(
              EneftyIcons.calendar_2_bold,
              size: 30,
              color: AppColors.primaryColor,
            ),
            label: "ปฏิทิน",
          ),
          NavigationDestination(
            icon: Icon(
              EneftyIcons.message_2_outline,
              size: 30,
              color: AppColors.primaryColor,
            ),
            selectedIcon: Icon(
              EneftyIcons.message_2_bold,
              size: 30,
              color: AppColors.primaryColor,
            ),
            label: "นัดหมาย",
          ),
          NavigationDestination(
            icon: Icon(
              EneftyIcons.user_tag_outline,
              size: 30,
              color: AppColors.primaryColor,
            ),
            selectedIcon: Icon(
              EneftyIcons.user_tag_bold,
              size: 30,
              color: AppColors.primaryColor,
            ),
            label: "Profile",
          ),
        ],
        selectedIndex: IndexPage,
        onDestinationSelected: (index) {
          setState(() {
            IndexPage = index;
          });
        },
      ),
    );
  }
}
