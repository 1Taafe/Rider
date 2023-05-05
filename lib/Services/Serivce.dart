import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Classes/User.dart';

class Service{
  static String uri = "http://localhost:3000";
  static User? currentUser;

  static bool isLoading = false;

  static Future<dynamic> getTripPassengers(int tripId) async {
    var url = '$uri/getTripPassengers';
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
    var url = '$uri/cancelTrip';
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
    var url = '$uri/completeTrip';
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
    var url = '$uri/getAllDriverTrips';
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
    var url = '$uri/createTrip';
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
    var url = '$uri/cancelPlace';
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
    var url = '$uri/reservePlace';
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
    var url = '$uri/checkPlace';
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
    var url = '$uri/getAllPassengerTrips';
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
    var url = '$uri/findTrips';
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
    var url = '$uri/getCities';
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
    var url = '$uri/register';
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
    var url = '$uri/auth';

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