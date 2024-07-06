import 'dart:convert';

class ContactInsertModel {
  // final int userId;
  final String line;
  final String phoneNumber;
  final String facebook;
  final String updatedAt;
  final String createdAt;
  final int id;

  ContactInsertModel({
    // required this.userId,
    required this.line,
    required this.phoneNumber,
    required this.facebook,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory ContactInsertModel.fromJson(Map<String, dynamic> json) =>
      ContactInsertModel(
        // userId: json["user_id"],
        line: json["line"],
        phoneNumber: json["phone_number"],
        facebook: json["facebook"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
      );
}
