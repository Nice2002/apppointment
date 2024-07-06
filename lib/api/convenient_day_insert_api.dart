import 'dart:convert';

class ConvenientDayInsertModel {
  final String userId;
  final String day;
  final String timeStart;
  final String timeEnd;
  final String updatedAt;
  final String createdAt;
  final int id;

  ConvenientDayInsertModel({
    required this.userId,
    required this.day,
    required this.timeStart,
    required this.timeEnd,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory ConvenientDayInsertModel.fromJson(Map<String, dynamic> json) =>
      ConvenientDayInsertModel(
        userId: json["user_id"],
        day: json["day"],
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
      );
}
