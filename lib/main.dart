import 'package:flutter/material.dart';
import 'package:rider/pages/LoginPage.dart';
import 'package:rider/pages/RegisterPage.dart';

void main() {
  runApp(MaterialApp(
    title: 'Rider',
    theme: ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.deepPurple,
    ),
    initialRoute: "/",
    routes: {
      "/" : (context) => const LoginPage(title: 'Rider',),
      "/register" : (context) => const RegisterPage()
    },
    debugShowCheckedModeBanner: false,
  ));
}
