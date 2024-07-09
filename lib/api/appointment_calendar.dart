import 'dart:convert';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class AppointmentCalendarModel {
  final int id;
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
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  AppointmentCalendarModel({
    required this.id,
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
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory AppointmentCalendarModel.fromJson(Map<String, dynamic> json) =>
      AppointmentCalendarModel(
        id: json["id"],
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );
}

Future<List<AppointmentCalendarModel>> fetchAppointmentCalendar(
    dynamic user_id) async {
  final response = await http.get(
      Uri.parse(
          'https://appt-cis.smt-online.com/api/appointment/calendar/$user_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      });
  if (response.statusCode == 200) {
    final List<dynamic> data =
        json.decode(response.body); // แปลง JSON ให้เป็น List
    return data
        .map((appointment) => AppointmentCalendarModel.fromJson(appointment))
        .toList(); // แปลง List ของ JSON ให้เป็น List ของ Model
  } else {
    throw Exception('Failed to load data from API');
  }
}
