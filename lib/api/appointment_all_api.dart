import 'dart:convert';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class AppointmentAllModel {
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
  final dynamic? notApprovedDetail;
  final String email;
  final dynamic? studentId;
  final String prefix;
  final String firstName;
  final String lastName;
  final dynamic? courseId;
  final String imageProfile;
  final int roleUser;
  final dynamic? contactId;
  final dynamic? line;
  final dynamic? phoneNumber;
  final dynamic? facebook;
  final dynamic? courseName;

  AppointmentAllModel({
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
    required this.email,
    required this.studentId,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    required this.courseId,
    required this.imageProfile,
    required this.roleUser,
    required this.contactId,
    required this.line,
    required this.phoneNumber,
    required this.facebook,
    required this.courseName,
  });

  factory AppointmentAllModel.fromJson(Map<String, dynamic> json) =>
      AppointmentAllModel(
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
        notApprovedDetail: json["notApprovedDetail"] ?? null,
        email: json["email"],
        studentId: json["student_id"] ?? null,
        prefix: json["prefix"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        courseId: json["course_id"] ?? null,
        imageProfile: json["image_profile"],
        roleUser: json["role_user"],
        contactId: json["contact_id"] ?? null,
        line: json["line"] ?? null,
        phoneNumber: json["phone_number"] ?? null,
        facebook: json["facebook"] ?? null,
        courseName: json["course_name"] ?? null,
      );
}

Future<AppointmentAllModel> fetchAppointmentAll(appointment_id) async {
  final response = await http.get(
      Uri.parse(
          'https://appt-cis.smt-online.com/api/appointment/all/$appointment_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      });
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return AppointmentAllModel.fromJson(data);
  } else {
    throw Exception('Failed to load data from API');
  }
}

Future<AppointmentAllModel> fetchAppointmentAllAnother(appointment_id) async {
  final response = await http.get(
      Uri.parse(
          'https://appt-cis.smt-online.com/api/appointment/all/target/$appointment_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      });
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return AppointmentAllModel.fromJson(data);
  } else {
    throw Exception('Failed to load data from API');
  }
}
