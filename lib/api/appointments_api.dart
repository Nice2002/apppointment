import 'dart:convert';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class AppointmentModel {
  final int appointmentId;
  final int userId;
  final int targetId;
  final DateTime date;
  final String timeStart;
  final String timeEnd;
  final String title;
  final String titleDetail;
  final String location;
  final int priorityLevel;
  final int status;
  final dynamic notApprovedDetail;
  final int id;
  final String email;
  final dynamic? studentId;
  final String prefix;
  final String firstName;
  final String lastName;
  final int courseId;
  final String imageProfile;

  AppointmentModel({
    required this.appointmentId,
    required this.userId,
    required this.targetId,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.title,
    required this.titleDetail,
    required this.location,
    required this.priorityLevel,
    required this.status,
    required this.notApprovedDetail,
    required this.id,
    required this.email,
    required this.studentId,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    required this.courseId,
    required this.imageProfile,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        appointmentId: json["appointment_id"],
        userId: json["user_id"],
        targetId: json["target_id"],
        date: DateTime.parse(json["date"]),
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        title: json["title"],
        titleDetail: json["title_detail"],
        location: json["location"],
        priorityLevel: json["priority_level"],
        status: json["status"],
        notApprovedDetail: json["notApprovedDetail"],
        id: json["id"],
        email: json["email"],
        studentId: json["student_id"] ?? null,
        prefix: json["prefix"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        courseId: json["course_id"],
        imageProfile: json["image_profile"],
      );
}

Future<List<AppointmentModel>> fetchAppointmentMe(user_id) async {
  final response = await http.get(
    Uri.parse(
        'https://appt-cis.smt-online.com/api/appointment/user_id/${user_id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*',
      'connection': 'keep-alive',
      'Authorization': 'Bearer ' + globals.jwtToken,
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> dataList = json.decode(response.body) as List<dynamic>;
    final List<AppointmentModel> appointments =
        dataList.map((json) => AppointmentModel.fromJson(json)).toList();
    return appointments;
  } else {
    throw Exception('Failed to load data from API');
  }
}

Future<List<AppointmentModel>> fetchAppointmentAnother(user_id) async {
  final response = await http.get(
    Uri.parse(
        'https://appt-cis.smt-online.com/api/appointment/target_id/${user_id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*',
      'connection': 'keep-alive',
      'Authorization': 'Bearer ' + globals.jwtToken,
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> dataList = json.decode(response.body) as List<dynamic>;
    final List<AppointmentModel> appointments =
        dataList.map((json) => AppointmentModel.fromJson(json)).toList();
    return appointments;
  } else {
    throw Exception('Failed to load data from API');
  }
}

Future<List<AppointmentModel>> fetchAppointmentWait(user_id) async {
  final response = await http.get(
    Uri.parse(
        'https://appt-cis.smt-online.com/api/appointment/wait/${user_id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*',
      'connection': 'keep-alive',
      'Authorization': 'Bearer ' + globals.jwtToken,
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> dataList = json.decode(response.body) as List<dynamic>;
    final List<AppointmentModel> appointments =
        dataList.map((json) => AppointmentModel.fromJson(json)).toList();
    return appointments;
  } else {
    throw Exception('Failed to load data from API');
  }
}

Future<List<AppointmentModel>> fetchAppointmentStatus(user_id) async {
  final response = await http.get(
    Uri.parse(
        'https://appt-cis.smt-online.com/api/appointment/status/${user_id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*',
      'connection': 'keep-alive',
      'Authorization': 'Bearer ' + globals.jwtToken,
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> dataList = json.decode(response.body) as List<dynamic>;
    final List<AppointmentModel> appointments =
        dataList.map((json) => AppointmentModel.fromJson(json)).toList();
    return appointments;
  } else {
    throw Exception('Failed to load data from API');
  }
}

// Future<AppointmentModel> fetchAppointmentModelStatusCount(status) async {
//   final response = await http.get(
//       Uri.parse('https://appt-cis.smt-online.com/api/appointment/status/count/$status'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Accept': '*/*',
//         'connection': 'keep-alive',
//         'Authorization': 'Bearer ' + globals.jwtToken,
//       });
//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     return AppointmentModel.fromJson(data);
//   } else {
//     throw Exception('Failed to load data from API');
//   }
// }

// Future<List<AppointmentModel>> fetchAppointment(int user_id) async {
//   final response = await http.get(
//     Uri.parse('https://appt-cis.smt-online.com/api/appointment/user_id/$user_id'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': '*/*',
//       'connection': 'keep-alive',
//       'Authorization': 'Bearer ' + globals.jwtToken,
//     },
//   );
//   if (response.statusCode == 200) {
//     final data = json.decode(response.body) as Map<String, dynamic>;
//     final appointmentModel = AppointmentModel.fromJson(data);
//     return [appointmentModel]; // ส่งคืนเป็น List ที่มี AppointmentModel เดียว
//   } else {
//     throw Exception('Failed to load data from API');
//   }
// }

// Future<AppointmentModel> fetchAppointmentStatus(status) async {
//   final response = await http.get(
//       Uri.parse('https://appt-cis.smt-online.com/api/appointment/status/$status'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Accept': '*/*',
//         'connection': 'keep-alive',
//         'Authorization': 'Bearer ' + globals.jwtToken,
//       });
//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     return AppointmentModel.fromJson(data);
//   } else {
//     throw Exception('Failed to load data from API');
//   }
// }
