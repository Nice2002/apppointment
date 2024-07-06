import 'dart:convert';

class AppointmentInsertModel {
  final String userId;
  final String targetId;
  final String title;
  final String titleDetail;
  final String location;
  final String priorityLevel;
  final String date;
  final String timeStart;
  final String timeEnd;
  final String updatedAt;
  final String createdAt;
  final int id;

  AppointmentInsertModel({
    required this.userId,
    required this.targetId,
    required this.title,
    required this.titleDetail,
    required this.location,
    required this.priorityLevel,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory AppointmentInsertModel.fromJson(Map<String, dynamic> json) =>
      AppointmentInsertModel(
        userId: json["user_id"] ?? '',
        targetId: json["target_id"] ?? '',
        title: json["title"] ?? '',
        titleDetail: json["title_detail"] ?? '',
        location: json["location"] ?? '',
        priorityLevel: json["priority_level"] ?? '',
        date: json["date"] ?? '',
        timeStart: json["time_start"] ?? '',
        timeEnd: json["time_end"] ?? '',
        updatedAt: json["updated_at"] ?? '',
        createdAt: json["created_at"] ?? '',
        id: json["id"] ?? 0,
      );
}
