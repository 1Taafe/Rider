import 'package:flutter/cupertino.dart';
import 'package:rider/Pages/DriverHomePage.dart';
import 'package:rider/Pages/PassengerHomePage.dart';
import 'package:rider/Pages/RegisterPage.dart';

import '../Services/Serivce.dart';
import '../Services/SharedPrefs.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController loginTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPrefs.isUserExists().then((value){
      if(value){
        SharedPrefs.getUser().then((value){
          Service.currentUser = value;
          if(Service.currentUser!.role == "passenger"){
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext) {
                  return PassengerHomePage();
                }
            ));
          }
          else if(Service.currentUser!.role == "driver"){
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext) {
                  return DriverHomePage();
                }
            ));
          }
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Rider / Вход'),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              child: Text(
                "Войдите в учетную запись",
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    height: 0.9
                ),
              ),
            ),
            CupertinoTextField(
              placeholder: 'Имя пользователя',
              controller: loginTextController,
              prefix: Container(
                margin: EdgeInsets.only(left: 16),
                child: Icon(
                    CupertinoIcons.person
                ),
              ),
              padding: EdgeInsets.all(18),
            ),
            SizedBox(height: 16.0),
            CupertinoTextField(
              obscureText: true,
              controller: passwordTextController,
              placeholder: 'Пароль',
              prefix: Container(
                margin: EdgeInsets.only(left: 16),
                child: Icon(
                    CupertinoIcons.lock
                ),
              ),
              padding: EdgeInsets.all(18),
            ),
            SizedBox(height: 36.0),
            Visibility(
              visible: !Service.isLoading,
              child: CupertinoButton.filled(
                child: Text("Вход"),
                padding: EdgeInsets.fromLTRB(96, 20, 96, 20),
                onPressed: !Service.isLoading ? () {
                  login(loginTextController.text, passwordTextController.text);
                } : null,
              ),
            ),
            Visibility(
                visible: Service.isLoading,
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(
                    radius: 24,
                  ),
                )
            ),
            SizedBox(height: 10.0),
            CupertinoButton(
              child: Text('Создать новую учетную запись'),
              onPressed: (){
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext) {
                      return RegisterPage();
                    }
                ));
              },
            )
          ],
        ),
      ),
    );
  }

  void login(String username, String password) {
    setState(() {
      Service.isLoading = true;
    });
    Service.login(username, password).then((result)
    {
      setState(() {
        Service.isLoading = false;
      });
      SharedPrefs.saveUser(Service.currentUser!);
      if(Service.currentUser!.role == "passenger"){
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext) {
              return PassengerHomePage();
            }
        ));
      }
      else if(Service.currentUser!.role == "driver"){
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext) {
              return DriverHomePage();
            }
        ));
      }
    }).catchError((err) {
      setState(() {
        Service.isLoading = false;
      });
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Внимание'),
            content: Text(
                'Имя пользователя и пароль неверны! Проверьте вводимые данные и повторите попытку.'),
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