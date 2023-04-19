import 'package:flutter/cupertino.dart';

import '../Services/Serivce.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
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
                Container(
                  child: Text(
                      Service.currentUser!.displayedName
                  ),
                ),
              ],
            ),
          )

      ),
    );
  }
}