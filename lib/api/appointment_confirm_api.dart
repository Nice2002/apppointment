import 'dart:convert';

class AppointmentConfirmModel {
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
  final dynamic createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  AppointmentConfirmModel({
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

  factory AppointmentConfirmModel.fromJson(Map<String, dynamic> json) =>
      AppointmentConfirmModel(
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
