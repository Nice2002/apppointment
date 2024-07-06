import 'dart:convert';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class UserStudentModel {
  final int id;
  final String email;
  final String studentId;
  final String prefix;
  final String firstName;
  final String lastName;
  final int courseId;
  final dynamic? teacherRoom;
  final dynamic? teachingSchedulLlink;
  final dynamic? imageProfile;
  final int roleUser;
  final int roleAdmin;
  final dynamic emailVerifiedAt;
  final dynamic createdAt;
  final dynamic? updatedAt;
  final dynamic deletedAt;

  UserStudentModel({
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

  factory UserStudentModel.fromJson(Map<String, dynamic> json) =>
      UserStudentModel(
        id: json["id"],
        email: json["email"],
        studentId: json["student_id"],
        prefix: json["prefix"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        courseId: json["course_id"],
        teacherRoom: json["teacher_room"] ?? null,
        teachingSchedulLlink: json["teachingSchedulLlink"] ?? null,
        imageProfile: json["image_profile"] ?? null,
        roleUser: json["role_user"],
        roleAdmin: json["role_admin"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] ?? null,
        deletedAt: json["deleted_at"],
      );
}

Future<List<UserStudentModel>> fetchUserStudent() async {
  final response = await http.get(
      Uri.parse('https://appt-cis.smt-online.com/api/users/student'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      });

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    List<UserStudentModel> users =
        data.map((json) => UserStudentModel.fromJson(json)).toList();
    return users;
  } else {
    throw Exception('Failed to load data from API');
  }
}
