import 'package:flutter/cupertino.dart';

import 'Pages/LoginPage.dart';

void main() {
  runApp(CupertinoApp(
    title: 'Rider',
    initialRoute: "/",
    routes: {
      "/" : (context) => LoginPage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
