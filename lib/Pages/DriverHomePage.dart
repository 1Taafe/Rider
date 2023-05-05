import 'package:flutter/cupertino.dart';
import 'package:rider/Pages/CreateTripPage.dart';
import 'package:rider/Pages/FindTripPage.dart';
import 'package:rider/Services/LocalDatabase.dart';
import 'package:rider/Services/SharedPrefs.dart';

import '../Services/Serivce.dart';
import 'DriverTripsPage.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {

  void showAboutDialog() {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 32,),
                        Icon(CupertinoIcons.info_circle_fill, size: 64,),
                        SizedBox(height: 32,),
                        Text("Приложение поиска попутчиков Rider"),
                        Text("Разработчик: Заянковский Дмитрий"),
                        Text("Создано в рамках курсового проекта"),
                        Text("2023г."),
                      ],
                    ),
                  )
                ],
              )
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Rider / ${Service.currentUser?.role}'),
      ),
      child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    "Добро пожаловать!",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 4,),
                Container(
                  child: Text(
                    Service.currentUser!.displayedName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 36
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "${Service.currentUser?.phoneNumber}",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 32),
                  child: Row(
                    children: [
                      Container(
                        width: 360,
                        child: CupertinoButton(
                            color: CupertinoColors.activeOrange,
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: Column(
                              children: [
                                Icon(CupertinoIcons.add_circled, size: 48,),
                                SizedBox(height: 8,),
                                Text("Создать поездку")
                              ],
                            ),
                            onPressed: (){
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (BuildContext) {
                                    return CreateTripPage();
                                  }
                              ));
                            }
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 360,
                        child: CupertinoButton(
                            color: CupertinoColors.activeOrange,
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: Column(
                              children: [
                                Icon(CupertinoIcons.rocket, size: 48,),
                                SizedBox(height: 8,),
                                Text("Мои поездки")
                              ],
                            ),
                            onPressed: (){
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (BuildContext) {
                                    return DriverTripsPage();
                                  }
                              ));
                            }
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 164,
                        child: CupertinoButton(
                            color: CupertinoColors.activeOrange,
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: Column(
                              children: [
                                Icon(CupertinoIcons.arrow_left_circle, size: 48,),
                                SizedBox(height: 8,),
                                Text("Выйти")
                              ],
                            ),
                            onPressed: (){
                              SharedPrefs.clearUser();
                              LocalDatabase.deleteAllData();
                              Navigator.of(context).pop();
                            }
                        ),
                      ),
                      SizedBox(width: 32,),
                      Container(
                        width: 164,
                        child: CupertinoButton(
                            color: CupertinoColors.activeOrange,
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: Column(
                              children: [
                                Icon(CupertinoIcons.info_circle, size: 48,),
                                SizedBox(height: 8,),
                                Text("О приложении")
                              ],
                            ),
                            onPressed: (){
                              showAboutDialog();
                            }
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ],
            ),
          )

      ),
    );
  }
}