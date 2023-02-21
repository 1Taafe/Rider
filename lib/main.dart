import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Rider'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 96),
            child: const Center(
              child: Text(
                'Вход',
                style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 300),
                child: const TextField(
                  decoration: InputDecoration(
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
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Пароль",
                        filled: true
                    ),
                  ),
                ),
              )
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 36),
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 240, height: 48),
                child: ElevatedButton(
                  onPressed: () {  },
                  child: const Text(
                    'Войти'
                  ),
                ),
              )
            ),
          ),
          Center(
            child: Container(
                margin: const EdgeInsets.only(top: 16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 200, height: 36),
                  child: OutlinedButton(
                    onPressed: () {  },
                    child: const Text(
                        'Регистрация'
                    ),
                  ),
                )
            ),
          ),
          Center(
            child: Container(
                margin: const EdgeInsets.fromLTRB(32, 24, 32, 0),
              child: const Text(
                  """Приложение Rider позволит вам организовать собственную поездку, в которой вы будете водителем, а также забронировать место в качестве пассажира.
Мы рады каждому новому пользователю :)"""
              )
            )
          )
        ]
      )
    );
  }
}
