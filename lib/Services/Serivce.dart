import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Classes/City.dart';
import '../Classes/User.dart';

class Service{
  final String url = "http://localhost:3000";
  static User? currentUser;

  static Future<dynamic> getTripPassengers(int tripId) async {
    const String url = 'http://localhost:3000/getTripPassengers';
    final Map<String, dynamic> data = {
      "user_key" : currentUser?.key,
      "trip_id": tripId
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
      throw Exception('Failed to find any passengers');
    }
  }

  static Future<dynamic> cancelTrip(int tripId) async {
    const String url = 'http://localhost:3000/cancelTrip';
    final Map<String, dynamic> data = {
      "user_key" : currentUser?.key,
      "trip_id" : tripId
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
      throw Exception('Error under trip cancellation operation!');
    }
  }

  static Future<dynamic> completeTrip(int tripId) async {
    const String url = 'http://localhost:3000/completeTrip';
    final Map<String, dynamic> data = {
      "user_key" : currentUser?.key,
      "trip_id" : tripId
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
      throw Exception('Error under trip complete operation!');
    }
  }

  static dynamic getDriverTrips() async {
    const String url = 'http://localhost:3000/getAllDriverTrips';
    final Map<String, dynamic> data = {
      "user_key" : currentUser?.key,
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

  static Future<dynamic> createTrip(String departureCity, String destinationCity,
      String departureTime, String destinationTime, String carModel, String carNumber,
      String description, double cost, int maxPlaces) async {
    const String url = 'http://localhost:3000/createTrip';
    final Map<String, dynamic> data = {
      "departure_city" : departureCity,
      "destination_city" : destinationCity,
      "user_key" : currentUser?.key,
      "car_number" : carNumber,
      "car_model" : carModel,
      "description" : description,
      "departure_time" : departureTime,
      "destination_time" : destinationTime,
      "max_places" : maxPlaces,
      "cost" : cost
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
      throw Exception('Error under trip creation operation!');
    }
  }

  static Future<dynamic> cancelPlace(int tripId) async {
    const String url = 'http://localhost:3000/cancelPlace';
    final Map<String, dynamic> data = {
      "user_key" : currentUser?.key,
      "trip_id" : tripId
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
      throw Exception('Error under place cancellation operation!');
    }
  }

  static Future<dynamic> reservePlace(int tripId) async {
    const String url = 'http://localhost:3000/reservePlace';
    final Map<String, dynamic> data = {
      "user_key" : currentUser?.key,
      "trip_id" : tripId
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
      throw Exception('Error under place reservation operation!');
    }
  }

  static Future<dynamic> checkPlace(int tripId) async {
    const String url = 'http://localhost:3000/checkPlace';
    final Map<String, dynamic> data = {
      "user_key" : currentUser?.key,
      "trip_id" : tripId
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

  static dynamic getPassengerTrips() async {
    const String url = 'http://localhost:3000/getAllPassengerTrips';
    final Map<String, dynamic> data = {
      "user_key" : currentUser?.key,
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

  static dynamic findTrips(String departureCity, String destinationCity, String date) async {
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