import 'dart:convert';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class UserTeacherModel {
  final int id;
  final String email;
  final dynamic? studentId;
  final String prefix;
  final String firstName;
  final String lastName;
  final dynamic? courseId;
  final String teacherRoom;
  final String teachingSchedulLlink;
  final String imageProfile;
  final int roleUser;
  final int roleAdmin;
  final dynamic emailVerifiedAt;
  final dynamic createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  UserTeacherModel({
    required this.id,
    required this.email,
    required this.studentId,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    required this.courseId,
    required this.teacherRoom,
    required this.teachingSchedulLlink,
    required this.imageProfile,
    required this.roleUser,
    required this.roleAdmin,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory UserTeacherModel.fromJson(Map<String, dynamic> json) =>
      UserTeacherModel(
        id: json["id"],
        email: json["email"],
        studentId: json["student_id"] ?? null,
        prefix: json["prefix"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        courseId: json["course_id"] ?? null,
        teacherRoom: json["teacher_room"],
        teachingSchedulLlink: json["teachingSchedulLlink"],
        imageProfile: json["image_profile"],
        roleUser: json["role_user"],
        roleAdmin: json["role_admin"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );
}

Future<List<UserTeacherModel>> fetchUserTeacher() async {
  final response = await http.get(
      Uri.parse('https://appt-cis.smt-online.com/api/users/teacher'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      });

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    List<UserTeacherModel> users =
        data.map((json) => UserTeacherModel.fromJson(json)).toList();
    return users;
  } else {
    throw Exception('Failed to load data from API');
  }
}
