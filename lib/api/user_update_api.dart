import 'dart:convert';

class UserUpdateModel {
  final int id;

  final String imageProfile;

  final dynamic emailVerifiedAt;
  final dynamic createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  UserUpdateModel({
    required this.id,
    required this.imageProfile,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) =>
      UserUpdateModel(
        id: json["id"],
        imageProfile: json["image_profile"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );
}
