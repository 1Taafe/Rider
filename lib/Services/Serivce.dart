import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Classes/City.dart';
import '../Classes/User.dart';

class Service{
  final String url = "http://localhost:3000";
  static User? currentUser;
  static List<String> citiesStr = [];

  static Future<dynamic> findTrips(String departureCity, String destinationCity, String date) async {
    const String url = 'http://localhost:3000/findTrips';
    final Map<String, dynamic> data = {
      "user_key" : currentUser?.key,
      "departure_city" : departureCity,
      "destination_city" : destinationCity,
      "departure_date" : date
    };
    final http.Response response = await http.post(
        Uri.parse(url),
        body: json.encode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception('Failed to find any trips');
    }

  }

  static Future<dynamic> getCities() async {
    const String url = 'http://localhost:3000/getCities';
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception('Failed to post data to server.');
    }
  }

  static Future<dynamic> register(String username, String password,
      String phone, String displayedName, String role) async {
    const String url = 'http://localhost:3000/register';
    final Map<String, dynamic> data = {
      'username': username,
      'password': password,
      'phone_number': phone,
      'role': role,
      'displayed_name': displayedName
    };

    final http.Response response = await http.post(
      Uri.parse(url),
      body: json.encode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data to server.');
    }
  }

  static Future<dynamic> login(String username, String password) async {
    const String url = 'http://localhost:3000/auth';

    final Map<String, dynamic> data = {'username': username, 'password': password};

    final http.Response response = await http.post(
      Uri.parse(url),
      body: json.encode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      currentUser = User.fromMap(jsonDecode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data to server.');
    }
  }
}