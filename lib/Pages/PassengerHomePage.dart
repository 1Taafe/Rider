import 'package:flutter/cupertino.dart';
import 'package:rider/Pages/FindTripPage.dart';
import 'package:rider/Services/SharedPrefs.dart';

import '../Services/Serivce.dart';

class PassengerHomePage extends StatefulWidget {
  const PassengerHomePage({super.key});

  @override
  _PassengerHomePageState createState() => _PassengerHomePageState();
}

class _PassengerHomePageState extends State<PassengerHomePage> {

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
                    child: CupertinoButton.filled(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: Column(
                          children: [
                            Icon(CupertinoIcons.search, size: 48,),
                            SizedBox(height: 8,),
                            Text("Найти поездку")
                          ],
                        ),
                        onPressed: (){
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (BuildContext) {
                                return FindTripPage();
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
                    child: CupertinoButton.filled(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: Column(
                          children: [
                            Icon(CupertinoIcons.doc_plaintext, size: 48,),
                            SizedBox(height: 8,),
                            Text("Мои брони")
                          ],
                        ),
                        onPressed: (){

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
                    child: CupertinoButton.filled(
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
                          Navigator.of(context).pop();
                        }
                    ),
                  ),
                  SizedBox(width: 32,),
                  Container(
                    width: 164,
                    child: CupertinoButton.filled(
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