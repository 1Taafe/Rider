import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider/Pages/FindTripPage.dart';
import 'package:rider/Services/SharedPrefs.dart';

import '../Classes/Person.dart';
import '../Classes/Trip.dart';
import '../Services/Serivce.dart';

class FoundTripsPage extends StatefulWidget {
  const FoundTripsPage({super.key, required this.tripsDate});
  final String tripsDate;

  @override
  _FoundTripsPageState createState() => _FoundTripsPageState();
}

class _FoundTripsPageState extends State<FoundTripsPage> {

  void showTripDialog2(Trip trip) {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 32,),
                        Icon(CupertinoIcons.car_detailed, size: 64,),
                        SizedBox(height: 32,),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 0.5,
                              ),
                              top: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                  CupertinoIcons.location_solid
                              ),
                              SizedBox(width: 8,),
                              Text("${trip.departureCity} - ${trip.destinationCity}")
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                CupertinoIcons.time_solid
                            ),
                            SizedBox(width: 8,),
                            Text("${trip.departureTime.hour}:${trip.departureTime.minute} - ${trip.destinationTime.hour}:${trip.destinationTime.minute}")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Стоимость: "),
                            SizedBox(width: 8,),
                            Icon(
                                CupertinoIcons.tag_circle_fill
                            ),
                            SizedBox(width: 8,),
                            Text("${trip.cost} BYN")
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
          ),
        ));
  }

  void showTripDialog(Trip trip) {
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
                          Text("${trip.departureTime.hour}:${trip.departureTime.minute} - ${trip.destinationTime.hour}:${trip.destinationTime.minute}")
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
                          Text("${trip.carModel} / ${trip.carModel}")
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Rider / ${widget.tripsDate}'),
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
                        print(trip);
                        showTripDialog(trip);
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
                              Text("${trip.departureTime.hour}:${trip.departureTime.minute} - ${trip.destinationTime.hour}:${trip.destinationTime.minute}",
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

