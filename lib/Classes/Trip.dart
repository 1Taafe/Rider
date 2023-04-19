class Trip{
  int id = -1;
  String departureCity = "";
  String destinationCity = "";
  String driverName = "";
  String driverPhone = "";
  String departureTimeString = "";
  DateTime departureTime = DateTime.now();
  String destinationTimeString = "";
  String carModel = "";
  DateTime destinationTime = DateTime.now();
  double cost = 0;
  int freePlaces = 0;

  @override
  String toString() {
    return "${departureCity} - ${destinationCity} / ${id}";
  }

  static List<Trip> foundList = <Trip>[];

  static Future<void> parseToList(Map<String, dynamic> input) async {
    Map<String, dynamic> jsonMap = input;
    List<dynamic> tripList = jsonMap['trips'];
    foundList.clear();

    for (Map<String, dynamic> tripMap in tripList) {
      Trip trip = Trip();
      trip.id = int.parse(tripMap['trip_id'].toString());
      trip.carModel = tripMap['car_model'].toString();
      trip.driverName = tripMap['driver_name'].toString();
      trip.driverPhone = tripMap['driver_phone'].toString();
      trip.departureCity = tripMap['departure_city'].toString();
      trip.destinationCity = tripMap['destination_city'].toString();
      trip.departureTimeString = tripMap['departure_time'].toString();
      trip.departureTime = DateTime.parse(trip.departureTimeString).toLocal();
      trip.destinationTimeString = tripMap['destination_time'].toString();
      trip.destinationTime = DateTime.parse(trip.destinationTimeString).toLocal();
      trip.cost = double.parse(tripMap['cost'].toString());
      trip.freePlaces = int.parse(tripMap['free_places'].toString());

      foundList.add(trip);
    }
  }


}