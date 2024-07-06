// import 'package:apppointment/page/add.dart';
// import 'package:apppointment/page/calendarpage.dart';
// import 'package:apppointment/page/home.dart';
// import 'package:apppointment/page/home_2.dart';
// import 'package:apppointment/page/message.dart';
// import 'package:apppointment/page/profile.dart';
// import 'package:flutter/material.dart';

// class Index extends StatefulWidget {
//   final int user_id;
//   final int roleUser;
//   const Index(this.user_id, this.roleUser, {Key? key}) : super(key: key);

//   @override
//   State<Index> createState() => _IndexState();
// }

// class _IndexState extends State<Index> {
//   int indexColor = 0;
//   late List<dynamic> screen;

//   @override
//   void initState() {
//     super.initState();
//     screen = [
//       HomeScreen(widget.user_id),
//       Calendarpage(widget.user_id),
//       Message(widget.user_id),
//       Profile(widget.user_id),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: Screen[index_color],
//       body: screen[indexColor],

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => Add(widget.user_id, widget.roleUser)));
//         },
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         elevation: 10,
//         backgroundColor: const Color.fromARGB(255, 13, 187, 158),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//       ),

//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3), // สีขอบเงา
//               blurRadius: 5.0, // ขยายขอบเงา
//               offset: const Offset(0, -2), // ตำแหน่งขอบเงา (x, y)
//             ),
//           ],
//         ),
//         child: BottomAppBar(
//           height: 75,
//           surfaceTintColor: Colors.white,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     indexColor = 0;
//                   });
//                 },
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.home,
//                       size: 30,
//                       color: indexColor == 0
//                           ? const Color.fromARGB(255, 13, 187, 158)
//                           : Colors.grey,
//                     ),
//                     Text(
//                       'หน้าแรก',
//                       style: TextStyle(
//                         color: indexColor == 0
//                             ? const Color.fromARGB(255, 13, 187, 158)
//                             : Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     indexColor = 1;
//                   });
//                 },
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.calendar_month,
//                       size: 30,
//                       color: indexColor == 1
//                           ? const Color.fromARGB(255, 13, 187, 158)
//                           : Colors.grey,
//                     ),
//                     Text(
//                       'ปฏิทิน',
//                       style: TextStyle(
//                         color: indexColor == 1
//                             ? const Color.fromARGB(255, 13, 187, 158)
//                             : Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     indexColor = 2;
//                   });
//                 },
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.message,
//                       size: 30,
//                       color: indexColor == 2
//                           ? const Color.fromARGB(255, 13, 187, 158)
//                           : Colors.grey,
//                     ),
//                     Text(
//                       'นัดหมาย',
//                       style: TextStyle(
//                         color: indexColor == 2
//                             ? const Color.fromARGB(255, 13, 187, 158)
//                             : Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     indexColor = 3;
//                   });
//                 },
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.person,
//                       size: 30,
//                       color: indexColor == 3
//                           ? const Color.fromARGB(255, 13, 187, 158)
//                           : Colors.grey,
//                     ),
//                     Text(
//                       'โปรไฟล์',
//                       style: TextStyle(
//                         color: indexColor == 3
//                             ? const Color.fromARGB(255, 13, 187, 158)
//                             : Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
