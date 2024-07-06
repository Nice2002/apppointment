import 'dart:convert';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class ContactModel {
  final int? contact_id;
  final int? userId;
  final dynamic? line; // กำหนดให้เป็น dynamic แทน int
  final dynamic? phoneNumber; // กำหนดให้เป็น dynamic แทน int
  final dynamic? facebook; // กำหนดให้เป็น dynamic แทน int
  final String? email;

  ContactModel({
    required this.contact_id,
    required this.userId,
    required this.line,
    required this.phoneNumber,
    required this.facebook,
    required this.email,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        contact_id: json["contact_id"] ?? null,
        userId: json["user_id"] ?? null,
        line: json["line"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        facebook: json["facebook"] ?? "",
        email: json["email"] ?? null,
      );
}

Future<ContactModel?> fetchContact(user_id) async {
  final response = await http.get(
      Uri.parse('https://appt-cis.smt-online.com/api/contact/$user_id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      });
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return ContactModel.fromJson(data);
  } else {
    throw Exception('Failed to load data from API');
  }
}
