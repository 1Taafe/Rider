import 'package:flutter/cupertino.dart';

import '../Services/Serivce.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController displayedNameController = TextEditingController();

  int _selectedSegmentIndex = 0;
  String _selectedRole = "passenger";
  final Map<int, Widget> _children = {
    0: Container(
      padding: EdgeInsets.fromLTRB(40,12,40,12),
      child: Text('Пассажир'),
    ),
    1: Container(
      padding: EdgeInsets.fromLTRB(40,12,40,12),
      child: Text('Водитель'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Rider / Регистрация'),
      ),
      child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    "Введите необходимые данные",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        height: 0.92
                    ),
                  ),
                ),
                CupertinoTextField(
                  placeholder: 'Имя пользователя',
                  controller: usernameController,
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
                  placeholder: 'Пароль',
                  controller: passwordController,
                  obscureText: true,
                  prefix: Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Icon(
                        CupertinoIcons.lock
                    ),
                  ),
                  padding: EdgeInsets.all(18),
                ),
                SizedBox(height: 16.0),
                CupertinoTextField(
                  placeholder: 'Номер телефона',
                  controller: phoneController,
                  prefix: Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Icon(
                        CupertinoIcons.phone
                    ),
                  ),
                  padding: EdgeInsets.all(18),
                ),
                SizedBox(height: 16.0),
                CupertinoTextField(
                  placeholder: 'Отображаемое имя',
                  controller: displayedNameController,
                  prefix: Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Icon(
                        CupertinoIcons.person_3
                    ),
                  ),
                  padding: EdgeInsets.all(18),
                ),
                SizedBox(height: 20.0),
                Text('Выберите тип учетной записи'),
                SizedBox(height: 12.0),
                CupertinoSegmentedControl(
                  children: _children,
                  groupValue: _selectedSegmentIndex,
                  onValueChanged: (value) {
                    setState(() {
                      _selectedSegmentIndex = value;
                      if(_selectedSegmentIndex == 0){
                        _selectedRole = "passenger";
                      }
                      else if(_selectedSegmentIndex == 1){
                        _selectedRole = "driver";
                      }
                    });
                  },
                ),
                SizedBox(height: 16),
                Text('Роль учетной записи: $_selectedRole'),
                SizedBox(height: 64),
                CupertinoButton.filled(
                  // borderRadius: BorderRadius.all(Radius.circular(0)),
                  child: Text('Зарегистрироваться'),
                  padding: EdgeInsets.fromLTRB(54, 18, 54, 18),
                  onPressed: () {
                    String username = usernameController.text;
                    String password = passwordController.text;
                    String phone = phoneController.text;
                    String displayedName = displayedNameController.text;
                    String role = _selectedRole;
                    register(username, password, phone, role, displayedName);
                  },
                ),
              ],
            ),
          )

      ),
    );
  }

  void register(String username, String password, String phone, String role, String displayedName) {
    Service.register(username, password, phone, displayedName, role).then((result) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Регистрация'),
            content: Text(
                'Учетная запись успешно создана!'),
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
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Регистрация'),
            content: Text(
                'Произошла ошибка. Вероятно такой пользователь уже существует либо сервер недоступен!'),
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