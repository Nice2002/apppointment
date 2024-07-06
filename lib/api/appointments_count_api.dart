import 'dart:convert';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class AppointmentCountModel {
  final int count;

  AppointmentCountModel({
    required this.count,
  });

  factory AppointmentCountModel.fromJson(Map<String, dynamic> json) =>
      AppointmentCountModel(
        count: json["count"],
      );
}

Future<AppointmentCountModel> fetchAppointmentModelStatusCount(status) async {
  final response = await http.get(
      Uri.parse(
          'https://appt-cis.smt-online.com/api/appointment/status/count/$status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'connection': 'keep-alive',
        'Authorization': 'Bearer ' + globals.jwtToken,
      });
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return AppointmentCountModel.fromJson(data);
  } else {
    throw Exception('Failed to load data from API');
  }
}

Future<AppointmentCountModel> fetchAppointmentModelStatusCountUser(
    status, int user_id) async {
  final response = await http.post(
    Uri.parse(
        'https://appt-cis.smt-online.com/api/appointment/status/count/user/$status'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*',
      'connection': 'keep-alive',
      'Authorization': 'Bearer ' + globals.jwtToken,
    },
    body: jsonEncode({
      'id': user_id,
    }),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return AppointmentCountModel.fromJson(data);
  } else {
    throw Exception('Failed to load data from API');
  }
}
