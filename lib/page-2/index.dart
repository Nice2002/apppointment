// import 'package:apppointment/page-2/add.dart';
// import 'package:apppointment/page-2/calendarpage.dart';
// import 'package:apppointment/page-2/home.dart';
// import 'package:apppointment/page-2/message.dart';
// import 'package:apppointment/page-2/profile.dart';
// import 'package:flutter/material.dart';

// class IndexAJ extends StatefulWidget {
//   const IndexAJ({super.key});

//   @override
//   State<IndexAJ> createState() => _IndexAJState();
// }

// class _IndexAJState extends State<IndexAJ> {
//   int index_color = 0;
//   List Screen = [
//     const Homepage(),
//     const Calendarpage(),
//     const Message(),
//     const Profile(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: Screen[index_color],
//       body: Screen[index_color],
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => const Add()));
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
//                     index_color = 0;
//                   });
//                 },
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.home,
//                       size: 30,
//                       color: index_color == 0
//                           ? const Color.fromARGB(255, 13, 187, 158)
//                           : Colors.grey,
//                     ),
//                     Text(
//                       'หน้าแรก',
//                       style: TextStyle(
//                         color: index_color == 0
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
//                     index_color = 1;
//                   });
//                 },
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.calendar_month,
//                       size: 30,
//                       color: index_color == 1
//                           ? const Color.fromARGB(255, 13, 187, 158)
//                           : Colors.grey,
//                     ),
//                     Text(
//                       'ปฏิทิน',
//                       style: TextStyle(
//                         color: index_color == 1
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
//                     index_color = 2;
//                   });
//                 },
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.message,
//                       size: 30,
//                       color: index_color == 2
//                           ? const Color.fromARGB(255, 13, 187, 158)
//                           : Colors.grey,
//                     ),
//                     Text(
//                       'นัดหมาย',
//                       style: TextStyle(
//                         color: index_color == 2
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
//                     index_color = 3;
//                   });
//                 },
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.person,
//                       size: 30,
//                       color: index_color == 3
//                           ? const Color.fromARGB(255, 13, 187, 158)
//                           : Colors.grey,
//                     ),
//                     Text(
//                       'โปรไฟล์',
//                       style: TextStyle(
//                         color: index_color == 3
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
