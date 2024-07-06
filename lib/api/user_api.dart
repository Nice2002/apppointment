import 'dart:convert';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class UserModel {
  final int id;
  final dynamic email;
  final dynamic studentId;
  final String? prefix;
  final String? firstName;
  final String? lastName;
  final dynamic courseId;
  final dynamic teacherRoom;
  final dynamic teachingSchedulLlink;
  final int? roleUser;
  final int? roleAdmin;
  final String? imageProfile;
  final dynamic emailVerifiedAt;
  final dynamic courseName;

  UserModel({
    required this.id,
    required this.email,
    required this.studentId,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    required this.courseId,
    required this.teacherRoom,
    required this.teachingSchedulLlink,
    required this.roleUser,
    required this.roleAdmin,
    required this.imageProfile,
    required this.emailVerifiedAt,
    required this.courseName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"] ?? null,
        studentId: json["student_id"] ?? null,
        prefix: json["prefix"] ?? null,
        firstName: json["first_name"] ?? null,
        lastName: json["last_name"] ?? null,
        courseId: json["course_id"] ?? null,
        teacherRoom: json["teacher_room"] ?? null,
        teachingSchedulLlink: json["teachingSchedulLlink"] ?? null,
        roleUser: json["role_user"] ?? null,
        roleAdmin: json["role_admin"] ?? null,
        imageProfile: json["image_profile"] ?? null,
        emailVerifiedAt: json["email_verified_at"] ?? null,
        courseName: json["course_name"] ?? null,
      );
}

Future<UserModel> fetchUsers() async {
  final response = await http.get(
      Uri.parse('https://appt-cis.smt-online.com/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      });
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return UserModel.fromJson(data);
  } else {
    throw Exception('Failed to load data from API');
  }
}

Future<UserModel> fetchUser(user_id) async {
  final response = await http.get(
      Uri.parse('https://appt-cis.smt-online.com/api/user/course/$user_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      });
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return UserModel.fromJson(data);
  } else {
    throw Exception('Failed to load data from API');
  }
}
