import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>{

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String nickname = "";
  String password = "";
  String key = "";
  bool isLoaderVisible = false;
  static String role = "driver";

  @override
  void dispose() {
    _loginController.dispose(); // remember to dispose of the controller
    _passwordController.dispose();
    super.dispose();
  }

  void toggleLoaderVisibility() {
    setState(() {
      isLoaderVisible = !isLoaderVisible;
    });
  }

  bool isButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rider"),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: const Center(
                      child: Text(
                        'Регистрация',
                        style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  )
              ),
              Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 300),
                      child: TextField(
                        controller: _loginController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.badge),
                            hintText: "Логин",
                            filled: true
                        ),
                      ),
                    ),
                  )
              ),
              Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 300),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: "Пароль",
                            filled: true
                        ),
                      ),
                    ),
                  )
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.fromLTRB(0,12,0,8),
                        child: const Text(
                            'Выберите, кем вы являетесь:'
                        )
                    ),
                    const SingleChoice(),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                          margin: const EdgeInsets.only(top: 32),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(width: 200, height: 48),
                            child: FilledButton(
                              onPressed: isButtonEnabled ? onRegisterButtonPressed : null,
                              child: const Text(
                                  'Создать аккаунт'
                              ),
                            ),
                          )
                      ),
                    ),
                    Visibility(
                        visible: isLoaderVisible,
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(32,32, 0, 0),
                            child: const SpinKitSpinningLines(
                              color: Colors.deepPurple,
                              duration: Duration(milliseconds: 2200),
                              size: 48.0,
                            ),
                          ),
                        )
                    )
                  ],
                ),
              )
            ]
        )
    );
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = !isButtonEnabled;
    });
  }

  void onRegisterButtonPressed() {
    updateButtonState();
    toggleLoaderVisibility();
    nickname = _loginController.text;
    var bytes = utf8.encode(_passwordController.text);
    password = sha256.convert(bytes).toString();
    key = nickname.hashCode.toString();
    registerRequest(nickname, password, key, role)
        .then((value) {
          updateButtonState();
        })
        .catchError((error) {
          showAlertDialog(context, "Ошибка", error.toString());
          toggleLoaderVisibility();
          updateButtonState();
        }
    );
  }

  Future<void> registerRequest(String nickname, String password, String key, String role) async {
    final url = Uri.parse('http://localhost:3000/users');
    final response = await http.post(url, body: {
      'nickname': nickname,
      'password': password,
      'key': key,
      'role' : role
    });
    if (response.statusCode == 200) {
      toggleLoaderVisibility();
      showAlertDialogWithAction(context, 'Уведомление', response.body, (){
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      });
    }
    else {
      showAlertDialog(context, 'Ошибка', response.body);
      toggleLoaderVisibility();
    }
  }

  void showAlertDialogWithAction(BuildContext context, String title, String message, VoidCallback action) {
    // Create the AlertDialog
    AlertDialog dialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {

            Navigator.of(context).pop();
            action();
          },
        ),
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // Create the AlertDialog
    AlertDialog dialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

}

enum Person { driver, passenger }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Person personView = Person.driver;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Person>(
      segments: const <ButtonSegment<Person>>[
        ButtonSegment<Person>(
            value: Person.driver,
            label: Padding(
              padding: EdgeInsets.fromLTRB(16,12,16,12),
              child: Text(
                  "Водитель"
              ),
            ),
            icon: Icon(Icons.drive_eta_rounded)),
        ButtonSegment<Person>(
            value: Person.passenger,
            label: Text('Пассажир'),
            icon: Icon(Icons.man)),
      ],
      selected: <Person>{personView},
      onSelectionChanged: (Set<Person> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          personView = newSelection.first;
          if(newSelection.first == Person.driver){
            RegisterPageState.role = "driver";
          }
          else{
            RegisterPageState.role = "passenger";
          }
        });
      },
    );
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // Create the AlertDialog
    AlertDialog dialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

}