import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Classes/Trip.dart';

class LocalDatabase {
  static Future<Database> getInstance() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE routes (id INTEGER PRIMARY KEY AUTOINCREMENT, departure_city TEXT, destination_city TEXT);",
        );

        await database.execute(
            "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone_number TEXT);"
        );

        await database.execute(
            "CREATE TABLE cars (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER, model TEXT, number TEXT,"
                "FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE);"
        );

        await database.execute(
            "CREATE TABLE trips (id INTEGER PRIMARY KEY AUTOINCREMENT, route_id INTEGER, departure_time TEXT, destination_time TEXT, driver_id INTEGER, car_id INTEGER, cost FLOAT, description TEXT, status TEXT,"
                "FOREIGN KEY (route_id) REFERENCES routes(id) ON UPDATE CASCADE ON DELETE CASCADE,"
                "FOREIGN KEY (driver_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,"
                "FOREIGN KEY (car_id) REFERENCES cars(id) ON UPDATE CASCADE ON DELETE CASCADE);"
        );
      },
      version: 1,
    );
  }

  static Future<void> createNewTrip(Trip trip) async {
    final database = await getInstance();
    // First, insert the user into the "users" table
    final userId = await database.rawInsert(
        "INSERT INTO users(name, phone_number) VALUES(?, ?)",
        [trip.driverName, trip.driverPhone]);

    // Next, insert the car into the "cars" table
    final carId = await database.rawInsert(
        "INSERT INTO cars(user_id, model, number) VALUES(?, ?, ?)",
        [userId, trip.carModel, trip.carNumber]);

    // Then, insert the route into the "routes" table
    final routeId = await database.rawInsert(
        "INSERT INTO routes(departure_city, destination_city) VALUES(?, ?)",
        [trip.departureCity, trip.destinationCity]);

    // Finally, insert the trip into the "trips" table
    await database.rawInsert(
        "INSERT INTO trips(route_id, departure_time, destination_time, driver_id, car_id, cost, description, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?)",
        [routeId, trip.departureTimeString, trip.destinationTimeString, userId, carId, trip.cost, trip.description, trip.status]);
  }


  static Future<List<Trip>> getAllTripsWithDetails() async {
    final database = await getInstance();
    // Fetch all trips with details from the database
    final List<Map<String, dynamic>> tripMaps = await database.rawQuery('''
    SELECT trips.id, departure_city, destination_city, name, phone_number, model, number, departure_time, destination_time, cost, description, status
    FROM trips
    INNER JOIN routes ON trips.route_id = routes.id
    INNER JOIN users ON trips.driver_id = users.id
    INNER JOIN cars ON trips.car_id = cars.id
  ''');

    // Convert each map to a Trip object and return the list
    return tripMaps.map((tripMap) {
      final String departureTimeString = tripMap['departure_time'];
      final String destinationTimeString = tripMap['destination_time'];

      return Trip.byLocal(
        tripMap['departure_city'],
        tripMap['destination_city'],
        tripMap['name'],
        tripMap['phone_number'],
        tripMap['model'],
        tripMap['number'],
        departureTimeString,
        destinationTimeString,
        tripMap['cost'],
        tripMap['status'],
      )..description = tripMap['description']
        ..id = tripMap['id'];
    }).toList();
  }

  static Future<void> deleteAllData() async {
    final database = await getInstance();
    await database.execute("DELETE FROM trips;");
    await database.execute("DELETE FROM routes;");
    await database.execute("DELETE FROM cars;");
    await database.execute("DELETE FROM users;");
  }


}