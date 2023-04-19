import 'package:flutter/cupertino.dart';
import 'package:rider/Pages/FoundTripsPage.dart';

import '../Classes/City.dart';
import '../Classes/Trip.dart';
import '../Services/Serivce.dart';

const double _kItemExtent = 48.0;

class FindTripPage extends StatefulWidget {
  const FindTripPage({super.key});

  @override
  _FindTripPageState createState() => _FindTripPageState();
}

class _FindTripPageState extends State<FindTripPage> {

  void getListOfCities() {
    Service.getCities().then((result){
      Map<String, dynamic> jsonMap = result;
      List<dynamic> cityList = jsonMap['result'];
      List<City> cities = [];
      _cities.clear();

      for (Map<String, dynamic> cityMap in cityList) {
        City city = City();
        city.id = cityMap['id'];
        city.name = cityMap['name'];
        _cities.add(city.name);
        cities.add(city);
      }

      print(cities);
    }).catchError((error){

    });
  }

  List<String> _cities = ["Выберите город"];

  DateTime date = DateTime(2023, 04, 13);
  String formattedDate = "2023-04-13";
  int _selectedDepartureCity = 0;
  int _selectedDestinationCity = 0;
  String departureCity = "";
  String destinationCity = "";

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 316,
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
            child: child,
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    getListOfCities();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Rider / findTrip'),
      ),
      child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 64,),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Откуда: '),
                        CupertinoButton(
                          padding: EdgeInsets.all(16),
                          // Display a CupertinoPicker with list of fruits.
                          onPressed: () => _showDialog(
                            CupertinoPicker(
                              magnification: 1.22,
                              squeeze: 1.2,
                              useMagnifier: true,
                              itemExtent: _kItemExtent,
                              // This is called when selected item is changed.
                              onSelectedItemChanged: (int selectedItem) {
                                setState(() {
                                  _selectedDepartureCity = selectedItem;
                                  departureCity = _cities[selectedItem];
                                });
                              },
                              children:
                              List<Widget>.generate(_cities.length, (int index) {
                                return Center(
                                  child: Text(
                                    _cities[index],
                                  ),
                                );
                              }),
                            ),
                          ),
                          // This displays the selected fruit name.
                          child: Text(
                            _cities[_selectedDepartureCity],
                            style: const TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Куда: '),
                        CupertinoButton(
                          padding: EdgeInsets.all(16),
                          // Display a CupertinoPicker with list of fruits.
                          onPressed: () => _showDialog(
                            CupertinoPicker(
                              magnification: 1.22,
                              squeeze: 1.2,
                              useMagnifier: true,
                              itemExtent: _kItemExtent,
                              // This is called when selected item is changed.
                              onSelectedItemChanged: (int selectedItem) {
                                setState(() {
                                  _selectedDestinationCity = selectedItem;
                                  destinationCity = _cities[selectedItem];
                                });
                              },
                              children:
                              List<Widget>.generate(_cities.length, (int index) {
                                return Center(
                                  child: Text(
                                    _cities[index],
                                  ),
                                );
                              }),
                            ),
                          ),
                          // This displays the selected fruit name.
                          child: Text(
                            _cities[_selectedDestinationCity],
                            style: const TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _DatePickerItem(
                  children: <Widget>[
                    const Text('День отправления'),
                    CupertinoButton(
                      // Display a CupertinoDatePicker in date picker mode.
                      onPressed: () => _showDialog(
                        CupertinoDatePicker(
                          initialDateTime: date,
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          // This is called when the user changes the date.
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() => date = newDate);
                            formattedDate = "${date.year}-${date.month}-${date.day}";
                          },
                        ),
                      ),
                      // In this example, the date is formatted manually. You can
                      // use the intl package to format the value based on the
                      // user's locale settings.
                      child: Text(
                        '${date.year}-${date.month}-${date.day}',
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(64,48,64,32),
                  child: CupertinoButton.filled(
                    padding: EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.search_circle),
                        SizedBox(width: 16,),
                        Text("Найти поездку")
                      ],
                    ),
                    onPressed: (){
                      findTrips(departureCity, destinationCity, formattedDate);
                    },
                  ),
                )
              ],
            ),
          )

      ),
    );
  }

  void findTrips(String departureCity, String destinationCity, String date){
    Service.findTrips(departureCity, destinationCity, date).then((result) {
      Trip.parseToList(result).then((result){
        print(Trip.foundList);
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext) {
              return FoundTripsPage(tripsDate: date);
            }
        ));
      });
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
                },
              ),
            ],
          );
        },
      );
    });
  }
}

class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}