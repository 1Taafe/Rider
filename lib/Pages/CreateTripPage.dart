import 'package:flutter/cupertino.dart';
import 'package:rider/Pages/FoundTripsPage.dart';

import '../Classes/City.dart';
import '../Classes/Trip.dart';
import '../Services/Serivce.dart';

const double _kItemExtent = 48.0;

class CreateTripPage extends StatefulWidget {
  const CreateTripPage({super.key});

  @override
  _CreateTripPageState createState() => _CreateTripPageState();
}

class _CreateTripPageState extends State<CreateTripPage> {

  void getListOfCities() {
    setState(() {
      Service.isLoading = true;
    });
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
      setState(() {
        Service.isLoading = false;
      });
    }).catchError((error){
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Внимание'),
            content: Text(
                'Не удалось установить соединение с сервером.'),
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
      setState(() {
        Service.isLoading = false;
      });
    });
  }

  List<String> _cities = ["Выберите город"];

  DateTime departureDate = DateTime(2023, 04, 13);
  DateTime destinationDate = DateTime(2023, 04, 13);

  int _selectedDepartureCity = 0;
  int _selectedDestinationCity = 0;

  //Query body params
  String departureCity = "";
  String destinationCity = "";
  String formattedDepartureDate = "2023-04-13 00:00";
  String formattedDestinationDate = "2023-04-13 12:00";
  int freePlaces = 1;
  TextEditingController carModelController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();


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
        middle: Stack(
          children: [
            Visibility(
              visible: !Service.isLoading,
              child: Text("Rider / createTrip"),
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 16,),
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
                      const Text('Дата отправления'),
                      CupertinoButton(
                        // Display a CupertinoDatePicker in date picker mode.
                        onPressed: () => _showDialog(
                          CupertinoDatePicker(
                            initialDateTime: departureDate,
                            mode: CupertinoDatePickerMode.dateAndTime,
                            use24hFormat: true,
                            // This is called when the user changes the date.
                            onDateTimeChanged: (DateTime newDate) {
                              setState(() => departureDate = newDate);
                              formattedDepartureDate = "${departureDate.year}-${departureDate.month.toString().padLeft(2, '0')}-${departureDate.day.toString().padLeft(2, '0')} ${departureDate.hour.toString().padLeft(2, '0')}:${departureDate.minute.toString().padLeft(2, '0')}";
                            },
                          ),
                        ),
                        // In this example, the date is formatted manually. You can
                        // use the intl package to format the value based on the
                        // user's locale settings.
                        child: Text(
                          formattedDepartureDate,
                          style: const TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _DatePickerItem(
                    children: <Widget>[
                      const Text('Дата прибытия'),
                      CupertinoButton(
                        // Display a CupertinoDatePicker in date picker mode.
                        onPressed: () => _showDialog(
                          CupertinoDatePicker(
                            initialDateTime: destinationDate,
                            mode: CupertinoDatePickerMode.dateAndTime,
                            use24hFormat: true,
                            // This is called when the user changes the date.
                            onDateTimeChanged: (DateTime newDate) {
                              setState(() => destinationDate = newDate);
                              formattedDestinationDate = "${destinationDate.year}-${destinationDate.month.toString().padLeft(2, '0')}-${destinationDate.day.toString().padLeft(2, '0')} ${destinationDate.hour.toString().padLeft(2, '0')}:${destinationDate.minute.toString().padLeft(2, '0')}";
                            },
                          ),
                        ),
                        // In this example, the date is formatted manually. You can
                        // use the intl package to format the value based on the
                        // user's locale settings.
                        child: Text(
                          formattedDestinationDate,
                          style: const TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ],
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
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: CupertinoTextField(
                          padding: EdgeInsets.all(19),
                          placeholder: "Модель автомобиля",
                          controller: carModelController,
                          placeholderStyle: TextStyle(
                              color: CupertinoColors.black
                          ),
                          prefixMode: OverlayVisibilityMode.always,
                          prefix: Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Icon(
                              CupertinoIcons.car_detailed,
                            ),
                          )
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
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: CupertinoTextField(
                          padding: EdgeInsets.all(19),
                          placeholder: "Номер автомобиля",
                          controller: carNumberController,
                          placeholderStyle: TextStyle(
                              color: CupertinoColors.black
                          ),
                          prefixMode: OverlayVisibilityMode.always,
                          prefix: Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Icon(
                              CupertinoIcons.number_circle,
                            ),
                          )
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
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: CupertinoTextField(
                          padding: EdgeInsets.all(19),
                          controller: descriptionController,
                          placeholder: "Описание",
                          placeholderStyle: TextStyle(
                              color: CupertinoColors.black
                          ),
                          prefixMode: OverlayVisibilityMode.always,
                          prefix: Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Icon(
                              CupertinoIcons.info_circle,
                            ),
                          )
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
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: CupertinoTextField(
                          padding: EdgeInsets.all(19),
                          controller: costController,
                          placeholder: "Стоимость",
                          placeholderStyle: TextStyle(
                              color: CupertinoColors.black
                          ),
                          prefixMode: OverlayVisibilityMode.always,
                          prefix: Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Icon(
                              CupertinoIcons.tags,
                            ),
                          )
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
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(
                                    CupertinoIcons.person_3,
                                  ),
                                ),
                                Text("Количество мест"),
                              ],
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                    child: Icon(CupertinoIcons.minus_circle),
                                    onPressed: (){
                                      setState(() {
                                        if(freePlaces > 1){
                                          freePlaces--;
                                        }
                                      });
                                    }
                                ),
                                Text(freePlaces.toString()),
                                CupertinoButton(
                                    child: Icon(CupertinoIcons.plus_circle),
                                    onPressed: (){
                                      setState(() {
                                        freePlaces++;
                                      });
                                    }
                                )
                              ],
                            )
                          ],
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(64,48,64,32),
                    child: CupertinoButton(
                      color: CupertinoColors.activeOrange,
                      padding: EdgeInsets.all(18),
                      child: !Service.isLoading ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.rocket),
                          SizedBox(width: 16,),
                          Text("Создать поездку")
                        ],
                      ) : CupertinoActivityIndicator(),
                      onPressed: !Service.isLoading ? (){
                        try{
                          createTrip(departureCity, destinationCity, formattedDepartureDate,
                              formattedDestinationDate, carModelController.text,
                              carNumberController.text, descriptionController.text,
                              double.parse(costController.text), freePlaces);
                        }
                        catch(error){
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text('Новая поездка'),
                                content: Text(
                                    'Произошла ошибка. Заполните правильно поля!'),
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
                      } : null,
                    ),
                  )
                ],
              ),
            )
          )

      ),
    );
  }

  void createTrip(String departureCity, String destinationCity,
      String departureTime, String destinationTime, String carModel, String carNumber,
      String description, double cost, int maxPlaces){
    setState(() {
      Service.isLoading = true;
    });
    Service.createTrip(departureCity, destinationCity, departureTime,
        destinationTime, carModel, carNumber, description, cost, maxPlaces).then((result){
          setState(() {
            Service.isLoading = false;
          });
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Новая поездка'),
            content: Text(
                'Поездка успешно создана!'),
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
            title: Text('Новая поездка'),
            content: Text(
                'Произошла ошибка. Не удалось создать новую поездку!'),
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