import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

final controller = TextEditingController();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Password Generator'),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Random Password Generator',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                readOnly: true,
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () {
                        final data = ClipboardData(text: controller.text);
                        Clipboard.setData(data);
                        final snackBar = SnackBar(
                          content: Text(
                            'Password Copied',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.pink,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    )),
              ),
              const SizedBox(height: 12),
              buildButton(),
            ],
          )),
    );
  }
}

Widget buildButton() {
  final backgroundColor = MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.pressed) ? Colors.pink : Colors.black);

  return ElevatedButton(
    style: ButtonStyle(backgroundColor: backgroundColor),
    child: Text('Generate Password'),
    onPressed: () {
      final password = generatePassword();
      controller.text = password;
    },
  );
}

String generatePassword({
  bool hasLetters = true,
  bool hasNumbers = true,
  bool hasSpecial = true,
}) {
  final length = 20;
  final lettersLowercase = 'abcdefghijklmnopqrstuvqxyz';
  final lettersUppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final numbers = '0123456789';
  final special = '@#=+!*"\$%&?(){}';
  String chars = '';
  if (hasLetters) chars += '$lettersLowercase$lettersUppercase';
  if (hasNumbers) chars += '$numbers';
  if (hasSpecial) chars += '$special';
  return List.generate(length, (index) {
    final indexRandom = Random.secure().nextInt(chars.length); //0...25
    return chars[indexRandom];
  }).join('');
}
