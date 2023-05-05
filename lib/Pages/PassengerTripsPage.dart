import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rider/Pages/FindTripPage.dart';
import 'package:rider/Services/LocalDatabase.dart';
import 'package:rider/Services/SharedPrefs.dart';

import '../Classes/Person.dart';
import '../Classes/Trip.dart';
import '../Services/Serivce.dart';

class PassengerTripsPage extends StatefulWidget {
  const PassengerTripsPage({super.key});

  @override
  _PassengerTripsPageState createState() => _PassengerTripsPageState();
}

enum Status { reserved, cancelled, cancelledByDriver, completed }

class _PassengerTripsPageState extends State<PassengerTripsPage> {

  void showTripDialog(Trip trip, bool isReserved) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 516,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
              top: false,
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                        bottom: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16,10,16,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Icon(
                                  CupertinoIcons.location_solid
                              ),
                              SizedBox(width: 8,),
                              Text("Маршрут")
                            ],
                          ),
                          Text("${trip.departureCity} - ${trip.destinationCity}")
                        ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                        bottom: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16,10,16,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Icon(
                                  CupertinoIcons.calendar_circle_fill
                              ),
                              SizedBox(width: 8,),
                              Text("Дата")
                            ],
                          ),
                          Text("${trip.departureTime.year}-${trip.departureTime.month}-${trip.destinationTime.day}")
                        ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                        bottom: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16,10,16,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Icon(
                                  CupertinoIcons.time_solid
                              ),
                              SizedBox(width: 8,),
                              Text("Время")
                            ],
                          ),
                          Text("${trip.departureTime.hour.toString().padLeft(2, '0')}:${trip.departureTime.minute.toString().padLeft(2, '0')} - ${trip.destinationTime.hour.toString().padLeft(2, '0')}:${trip.destinationTime.minute.toString().padLeft(2, '0')}")
                        ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                        bottom: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16,10,16,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Icon(
                                  CupertinoIcons.car_detailed
                              ),
                              SizedBox(width: 8,),
                              Text("Авто")
                            ],
                          ),
                          Text("${trip.carModel} / ${trip.carNumber}")
                        ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                        bottom: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16,10,16,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Icon(
                                  CupertinoIcons.person_alt_circle_fill
                              ),
                              SizedBox(width: 8,),
                              Text("Водитель")
                            ],
                          ),
                          Text("${trip.driverName}")
                        ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                        bottom: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16,10,16,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Icon(
                                  CupertinoIcons.phone_circle_fill
                              ),
                              SizedBox(width: 8,),
                              Text("Номер телефона")
                            ],
                          ),
                          Text("${trip.driverPhone}")
                        ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                        bottom: BorderSide(
                          color: CupertinoColors.inactiveGray,
                          width: 0.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16,10,16,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Icon(
                                  CupertinoIcons.tag_circle
                              ),
                              SizedBox(width: 8,),
                              Text("Стоимость")
                            ],
                          ),
                          Text("${trip.cost} BYN")
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: ReserveButton(isReserved: isReserved, trip: trip, callback: reloadTripsList,),
                  ),
                ],
              )
          ),
        ));
  }

  void reloadTripsList(){
    setState(() {
      Service.isLoading = true;
    });
    if(!kIsWeb){
      Service.getPassengerTrips().then((result) {
        var resultList = result;
        LocalDatabase.deleteAllData().then((result){
          Trip.parseToList(resultList, Trip.allTrips);
          for(Trip t in Trip.allTrips){
            LocalDatabase.createNewTrip(t);
          }
          Trip.sortByStatus();
          if(_selectedSegment == Status.reserved){
            selectedTrips = Trip.reservedTrips;
          }
          else if(_selectedSegment == Status.cancelled){
            selectedTrips = Trip.cancelledTrips;
          }
          else if(_selectedSegment == Status.completed){
            selectedTrips = Trip.completedTrips;
          }
          setState(() {
            Service.isLoading = false;
          });
        });
      }).catchError((error){
        // showCupertinoDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return CupertinoAlertDialog(
        //       title: Text('Внимание'),
        //       content: Text(
        //           error.toString() + "\n Вы в оффлайн режиме!"),
        //       actions: [
        //         CupertinoDialogAction(
        //           child: Text('OK'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
        LocalDatabase.getAllTripsWithDetails().then((result){
          Trip.allTrips = result;
          Trip.sortByStatus();
          if(_selectedSegment == Status.reserved){
            selectedTrips = Trip.reservedTrips;
          }
          else if(_selectedSegment == Status.cancelled){
            selectedTrips = Trip.cancelledTrips;
          }
          else if(_selectedSegment == Status.completed){
            selectedTrips = Trip.completedTrips;
          }
          setState(() {
            Service.isLoading = false;
          });
        });
      });
    }
    else{
      Service.getDriverTrips().then((result) {
        var resultList = result;
        Trip.parseToList(resultList, Trip.allTrips);
        Trip.sortByStatus();
        if(_selectedSegment == Status.reserved){
          selectedTrips = Trip.reservedTrips;
        }
        else if(_selectedSegment == Status.cancelled){
          selectedTrips = Trip.cancelledTrips;
        }
        else if(_selectedSegment == Status.completed){
          selectedTrips = Trip.completedTrips;
        }
        setState(() {
          Service.isLoading = false;
        });
      }).catchError((error){
        Service.isLoading = false;
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('Внимание'),
              content: Text(
                  error.toString() + "\n Не удалось загрузить данные!"),
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
      });
    }


  }

  Map<Status, Color> statusColors = <Status, Color>{
    Status.reserved: CupertinoColors.activeBlue,
    Status.cancelled: CupertinoColors.destructiveRed,
    Status.completed: CupertinoColors.activeGreen
  };

  @override
  void initState() {
    reloadTripsList();
    super.initState();
  }

  Status _selectedSegment = Status.reserved;

  List<Trip> selectedTrips = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Stack(
          children: [
            Visibility(
              visible: !Service.isLoading,
              child: Text("Rider / Trips (${selectedTrips.length})"),
            ),
            Visibility(
                visible: Service.isLoading,
                child: CupertinoActivityIndicator(
                  radius: 12,
                )
            ),
          ],
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(Icons.refresh),
          onPressed: () {
            reloadTripsList();
          },
        ),
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
                        Status.reserved: Padding(
                          padding: EdgeInsets.fromLTRB(20,12,20,12),
                          child: Text(
                            'Брони',
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
                  Expanded(
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
                              if(_selectedSegment != Status.completed){
                                Service.checkPlace(trip.id).then((result){
                                  //print(trip);
                                  showTripDialog(trip, true);
                                }).catchError((error){
                                  //print(trip);
                                  showTripDialog(trip, false);
                                });
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

class ReserveButton extends StatefulWidget {

  final bool isReserved;
  final Trip trip;
  final void Function() callback;

  ReserveButton({required this.isReserved, required this.trip, required this.callback});

  @override
  _ReserveButtonState createState() => _ReserveButtonState();
}

class _ReserveButtonState extends State<ReserveButton> {

  late bool isReserveButton;
  late Trip trip;

  @override
  void initState() {
    isReserveButton = widget.isReserved;
    trip = widget.trip;
    super.initState();
  }

  void _onReserve() {
    Service.reservePlace(trip.id).then((result){
      widget.callback();
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Бронирование'),
            content: Text(
                'Место успешно забронировано!'),
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
    }).catchError((error){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Бронирование'),
            content: Text(
                'Произошла ошибка! Вероятно свободных мест не осталось!'),
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

  void _onCancel() {
    Service.cancelPlace(trip.id).then((result){
      widget.callback();
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Бронирование'),
            content: Text(
                'Бронь успешно отменена!'),
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
    }).catchError((error){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Бронирование'),
            content: Text(
                'Произошла ошибка!'),
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

  @override
  Widget build(BuildContext context) {
    if(isReserveButton){
      return CupertinoButton(
        onPressed: _onReserve,
        color: CupertinoColors.activeBlue, // Set the desired background color
        borderRadius: BorderRadius.circular(8),
        child: Text(
          'Восстановить бронь',
          style: TextStyle(
            color: CupertinoColors.white, // Set the desired text color
          ),
        ),
      );
    }
    else{
      return CupertinoButton(
        onPressed: _onCancel,
        color: CupertinoColors.destructiveRed, // Set the desired background color
        borderRadius: BorderRadius.circular(8),
        child: Text(
          'Отменить бронь',
          style: TextStyle(
            color: CupertinoColors.white, // Set the desired text color
          ),
        ),
      );
    }

  }
}
