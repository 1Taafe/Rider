import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider/Pages/FindTripPage.dart';
import 'package:rider/Services/SharedPrefs.dart';

import '../Classes/Person.dart';
import '../Classes/Trip.dart';
import '../Services/Serivce.dart';

class FoundTripsPage extends StatefulWidget {
  const FoundTripsPage({super.key, required this.departureCity,
    required this.destinationCity, required this.tripsDate});

  final String departureCity;
  final String destinationCity;
  final String tripsDate;

  @override
  _FoundTripsPageState createState() => _FoundTripsPageState();
}

class _FoundTripsPageState extends State<FoundTripsPage> {

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
                                  CupertinoIcons.person_3_fill
                              ),
                              SizedBox(width: 8,),
                              Text("Кол-во свободных мест")
                            ],
                          ),
                          Text("${trip.freePlaces}")
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
      Trip.foundList.clear();
    });
    Service.findTrips(widget.departureCity, widget.destinationCity, widget.tripsDate).then((result) {
      Trip.parseToList(result, Trip.foundList);
      setState(() {
        Service.isLoading = false;
      });
    }).catchError((error){
      setState(() {
        Service.isLoading = false;
      });
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

  @override
  void initState() {
    reloadTripsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Stack(
          children: [
            Visibility(
              visible: !Service.isLoading,
              child: Text("Rider / ${widget.tripsDate}"),
            ),
            Visibility(
                visible: Service.isLoading,
                child: CupertinoActivityIndicator(
                  radius: 12,
                )
            ),
          ],
        ),
      ),
      child: SafeArea(
          child: Scaffold(
              body: ListView.builder(
                itemCount: Trip.foundList.length,
                itemBuilder: (BuildContext context, int index) {
                  final trip = Trip.foundList[index];
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
                        setState(() {
                          Service.isLoading = true;
                        });
                        Service.checkPlace(trip.id).then((result){
                          showTripDialog(trip, true);
                          setState(() {
                            Service.isLoading = false;
                          });
                        }).catchError((error){
                          showTripDialog(trip, false);
                          setState(() {
                            Service.isLoading = false;
                          });
                        });
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
    setState(() {
      Service.isLoading = true;
    });
    Service.reservePlace(trip.id).then((result){
      setState(() {
        Service.isLoading = false;
      });
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
      setState(() {
        Service.isLoading = false;
      });
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

  void _onCancel() {
    setState(() {
      Service.isLoading = true;
    });
    Service.cancelPlace(trip.id).then((result){
      setState(() {
        Service.isLoading = false;
      });
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
      setState(() {
        Service.isLoading = false;
      });
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
        onPressed: !Service.isLoading ? _onReserve : null,
        color: CupertinoColors.activeBlue, // Set the desired background color
        borderRadius: BorderRadius.circular(8),
        child: !Service.isLoading ? Text(
          'Забронировать',
          style: TextStyle(
            color: CupertinoColors.white, // Set the desired text color
          ),
        ) : CupertinoActivityIndicator(

        )
      );
    }
    else{
      return CupertinoButton(
        onPressed: !Service.isLoading ? _onCancel : null,
        color: CupertinoColors.destructiveRed, // Set the desired background color
        borderRadius: BorderRadius.circular(8),
          child: !Service.isLoading ? Text(
            'Отменить бронь',
            style: TextStyle(
              color: CupertinoColors.white, // Set the desired text color
            ),
          ) : CupertinoActivityIndicator(

          )
      );
    }

  }
}
