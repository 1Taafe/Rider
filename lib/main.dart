import 'package:flutter/cupertino.dart';
import 'package:rider/Services/LocalDatabase.dart';

import 'Pages/LoginPage.dart';

void main() async {
  runApp(CupertinoApp(
    title: 'Rider',
    initialRoute: "/",
    routes: {
      "/" : (context) => LoginPage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
