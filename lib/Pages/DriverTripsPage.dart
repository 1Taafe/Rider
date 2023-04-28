import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider/Pages/FindTripPage.dart';
import 'package:rider/Services/SharedPrefs.dart';

import '../Classes/Person.dart';
import '../Classes/Trip.dart';
import '../Classes/User.dart';
import '../Services/Serivce.dart';

class DriverTripsPage extends StatefulWidget {
  const DriverTripsPage({super.key});

  @override
  _DriverTripsPageState createState() => _DriverTripsPageState();
}

enum Status { created, cancelled, completed }

class _DriverTripsPageState extends State<DriverTripsPage> {

  String allPassengers = "";
  void _showActionSheet(BuildContext context, Trip trip) {
    Service.getTripPassengers(trip.id).then((result){
      User.parseToList(result, User.passengers);
      allPassengers = "";
      for(User p in User.passengers){
        allPassengers += "${p.displayedName} \t ${p.phoneNumber} \n";
      }
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('Управление поездкой',
            style: TextStyle(
                fontSize: 24
            ),),
          message: Text('Выберите действие, которое необходимо совершить. Внимание! Статус поездки невозможно изменить в последующем! Статус будет изменен для следующих пассажиров: \n\n' + allPassengers,
            style: TextStyle(
                fontSize: 18
            ),),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отмена'),
          ),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                completeTrip(trip);
                Navigator.pop(context);
              },
              child: const Text('Завершить поездку'),
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                cancelTrip(trip);
                Navigator.pop(context);
              },
              child: const Text('Отменить поездку'),
            ),
          ],
        ),
      );
    }).catchError((error){
      showAlertDialog("Управление поездкой", "Не удалось получить список пассажиров!");
    });
  }

  void cancelTrip(Trip trip){
    Service.cancelTrip(trip.id).then((result){
      reloadTripsList();
      showAlertDialog("Управление поездкой", 'Поездка успешно отменена!');
    }).catchError((error){
      showAlertDialog("Управление поездкой", 'Произошла ошибка! Поездка не отменена!');
    });
  }

  void completeTrip(Trip trip){
    Service.completeTrip(trip.id).then((result){
      reloadTripsList();
      showAlertDialog("Управление поездкой", 'Поездка отмечена как выполненная!');
    }).catchError((error){
      showAlertDialog("Управление поездкой", 'Произошла ошибка! Поездка не отмечена как выполненная!!');
    });
  }

  void showAlertDialog(String title, String content){
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(
              content),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void reloadTripsList(){
    Service.getDriverTrips().then((result) {
      Trip.parseToList(result, Trip.allTrips);
      Trip.sortByStatus();
      if(_selectedSegment == Status.created){
        selectedTrips = Trip.reservedTrips;
      }
      else if(_selectedSegment == Status.cancelled){
        selectedTrips = Trip.cancelledTrips;
      }
      else if(_selectedSegment == Status.completed){
        selectedTrips = Trip.completedTrips;
      }
      setState(() {});
    }).catchError((error){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Внимание'),
            content: Text(
                error.toString()),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  Map<Status, Color> statusColors = <Status, Color>{
    Status.created: CupertinoColors.activeBlue,
    Status.cancelled: CupertinoColors.destructiveRed,
    Status.completed: CupertinoColors.activeGreen
  };

  @override
  void initState() {
    reloadTripsList();
    super.initState();
  }

  Status _selectedSegment = Status.created;

  List<Trip> selectedTrips = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Rider / Trips"),
      ),
      child: SafeArea(
          child: Scaffold(
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: CupertinoSlidingSegmentedControl<Status>(
                      backgroundColor: CupertinoColors.systemGrey2,
                      thumbColor: statusColors[_selectedSegment]!,
                      // This represents the currently selected segmented control.
                      groupValue: _selectedSegment,
                      // Callback that sets the selected segmented control.
                      onValueChanged: (Status? value) {
                        reloadTripsList();
                        if (value != null) {
                          setState(() {
                            _selectedSegment = value;
                          });
                        }
                      },
                      children: const <Status, Widget>{
                        Status.created: Padding(
                          padding: EdgeInsets.fromLTRB(20,12,20,12),
                          child: Text(
                            'Созданы',
                            style: TextStyle(color: CupertinoColors.white),
                          ),
                        ),
                        Status.cancelled: Padding(
                          padding: EdgeInsets.fromLTRB(20,12,20,12),
                          child: Text(
                            'Отменены',
                            style: TextStyle(color: CupertinoColors.white),
                          ),
                        ),
                        Status.completed: Padding(
                          padding: EdgeInsets.fromLTRB(20,12,20,12),
                          child: Text(
                            'Завершены',
                            style: TextStyle(color: CupertinoColors.white),
                          ),
                        ),
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView.builder(
                      itemCount: selectedTrips.length,
                      itemBuilder: (BuildContext context, int index) {
                        final trip = selectedTrips[index];
                        return Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: ListTile(
                            onTap: (){
                              if(_selectedSegment == Status.created){
                                _showActionSheet(context, trip);
                              }
                            },
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.location),
                                    SizedBox(width: 8,),
                                    Text(trip.departureCity + " – " + trip.destinationCity,
                                      style: TextStyle(
                                          fontSize: 22,
                                          letterSpacing: 2
                                      ),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.calendar),
                                    SizedBox(width: 8,),
                                    Text("${trip.departureTime.day}.${trip.departureTime.month}.${trip.destinationTime.year}",
                                      style: TextStyle(
                                          fontSize: 18
                                      ),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.time),
                                    SizedBox(width: 8,),
                                    Text("${trip.departureTime.hour.toString().padLeft(2, '0')}:${trip.departureTime.minute.toString().padLeft(2, '0')} - ${trip.destinationTime.hour.toString().padLeft(2, '0')}:${trip.destinationTime.minute.toString().padLeft(2, '0')}",
                                      style: TextStyle(
                                          fontSize: 18
                                      ),),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Text('Авто: ${trip.carModel}'),
                                Text('Стоимость: ${trip.cost} BYN'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
          )

      ),
    );
  }
}
