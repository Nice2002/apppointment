import 'dart:convert';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class ConvenientDayModel {
  final int id;
  final int userId;
  final int day;
  final String timeStart;
  final String timeEnd;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  ConvenientDayModel({
    required this.id,
    required this.userId,
    required this.day,
    required this.timeStart,
    required this.timeEnd,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory ConvenientDayModel.fromJson(Map<String, dynamic> json) =>
      ConvenientDayModel(
        id: json["id"],
        userId: json["user_id"],
        day: json["day"],
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );
}

Future<List<ConvenientDayModel>> fetchConvenientDay(int userId) async {
  try {
    final response = await http.get(
      Uri.parse('https://appt-cis.smt-online.com/api/convenient/$userId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ${globals.jwtToken}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<ConvenientDayModel> convenientDays =
          data.map((json) => ConvenientDayModel.fromJson(json)).toList();
      return convenientDays;
    } else {
      throw Exception('Failed to load data from API: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data from API: $e');
  }
}
