import 'dart:convert';

class ContactUpdateModel {
  final int id;
  final int userId;
  final String line;
  final String phoneNumber;
  final String facebook;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  ContactUpdateModel({
    required this.id,
    required this.userId,
    required this.line,
    required this.phoneNumber,
    required this.facebook,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory ContactUpdateModel.fromJson(Map<String, dynamic> json) =>
      ContactUpdateModel(
        id: json["id"],
        userId: json["user_id"],
        line: json["line"],
        phoneNumber: json["phone_number"],
        facebook: json["facebook"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );
}
