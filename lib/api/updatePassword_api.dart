// To parse this JSON data, do
//
//     final updatPassword = updatPasswordFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UpdatPassword {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final String createdAt;
  final String updatedAt;

  UpdatPassword({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UpdatPassword.fromJson(Map<String, dynamic> json) => UpdatPassword(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        emailVerifiedAt: json["email_verified_at"] ?? null,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );
}
