class Trip{
  int id = -1;
  String description = "";
  String status = "";
  String departureCity = "";
  String destinationCity = "";
  String driverName = "";
  String driverPhone = "";
  String departureTimeString = "";
  DateTime departureTime = DateTime.now();
  String destinationTimeString = "";
  String carModel = "";
  String carNumber = "";
  DateTime destinationTime = DateTime.now();
  double cost = 0;
  int freePlaces = 0;

  Trip();

  Trip.byLocal(String departureCity, String destinationCity, String name,
      String phoneNumber, String carModel, String carNumber, String departureTime,
      String destinationTime, double cost, String status){
    this.departureCity = departureCity;
    this.destinationCity = destinationCity;
    this.driverName = name;
    this.driverPhone = phoneNumber;
    this.carModel = carModel;
    this.carNumber = carNumber;
    this.departureTimeString = departureTime;
    this.departureTime = DateTime.parse(this.departureTimeString).toLocal();
    this.destinationTimeString = destinationTime;
    this.destinationTime = DateTime.parse(this.destinationTimeString).toLocal();
    this.cost = cost;
    this.status = status;
  }

  @override
  String toString() {
    return "${departureCity} - ${destinationCity} / ${id}";
  }

  static List<Trip> foundList = <Trip>[];

  static List<Trip> allTrips = [];
  static List<Trip> reservedTrips = [];
  static List<Trip> cancelledTrips = [];
  //static List<Trip> cancelledByDriverTrips = [];
  static List<Trip> completedTrips = [];

  static void sortByStatus(){
    reservedTrips.clear();
    cancelledTrips.clear();
    //cancelledByDriverTrips.clear();
    completedTrips.clear();
    for(Trip trip in allTrips){
      if(trip.status == 'reserved' || trip.status == 'owned'){
        reservedTrips.add(trip);
      }
      else if(trip.status == 'completed'){
        completedTrips.add(trip);
      }
      else if(trip.status == 'cancelled by passenger'){
        cancelledTrips.add(trip);
      }
      else if(trip.status == 'cancelled by driver'){
        cancelledTrips.add(trip);
      }
    }
  }

  static void parseToList(Map<String, dynamic> input, List<Trip> list) {
    Map<String, dynamic> jsonMap = input;
    List<dynamic> tripList = jsonMap['trips'];
    list.clear();

    for (Map<String, dynamic> tripMap in tripList) {
      Trip trip = Trip();
      trip.id = int.parse(tripMap['trip_id'].toString());
      trip.description = tripMap['trip_description'].toString();
      trip.status = tripMap['status'].toString();
      trip.carModel = tripMap['car_model'].toString();
      trip.carNumber = tripMap['car_number'].toString();
      trip.driverName = tripMap['driver_name'].toString();
      trip.driverPhone = tripMap['driver_phone'].toString();
      trip.departureCity = tripMap['departure_city'].toString();
      trip.destinationCity = tripMap['destination_city'].toString();
      trip.departureTimeString = tripMap['departure_time'].toString();
      trip.departureTime = DateTime.parse(trip.departureTimeString).toLocal();
      trip.destinationTimeString = tripMap['destination_time'].toString();
      trip.destinationTime = DateTime.parse(trip.destinationTimeString).toLocal();
      trip.cost = double.parse(tripMap['cost'].toString());
      try{
        trip.freePlaces = int.parse(tripMap['free_places'].toString());
      }
      catch(exception){
        trip.freePlaces = -1;
      }

      list.add(trip);
    }
  }


}