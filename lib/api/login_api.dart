import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:convert';

class LoginResponse {
  final String email;
  final int userId;
  final String jwtToken;
  final String message;
  final int status;
  final String prefix;
  final String firstName;
  final String lastName;
  final int roleUser;

  LoginResponse({
    required this.email,
    required this.userId,
    required this.jwtToken,
    required this.message,
    required this.status,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    required this.roleUser,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        email: json["email"],
        userId: json["user_id"],
        jwtToken: json["jwt_token"],
        message: json["message"],
        status: json["status"],
        prefix: json["prefix"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        roleUser: json["role_user"],
      );
}
