import 'package:flutter/material.dart';

void main() => runApp(FlashDriveApp());

class FlashDriveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash-Drive',
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: const Text('FLash-Drive'),
          ),
          body: WordButton()),
    );
  }
}

class WordButtonState extends State<WordButton> {
  bool pressed = false;
  List<Map<String, String>> wordPair = [
    {'key': 'hai', 'value': 'yes'},
    {'key': 'iie', 'value': 'no'},
    {'key': 'arigatou', 'value': 'thank you'},
    {'key': 'gommenesai', 'value': 'sorry'}
  ];

  @override
  Widget build(BuildContext context) {
    var i = 3;

    String langKey = wordPair[i]['key'];
    String langValue = wordPair[i]['value'];

    return Center(
      child: MaterialButton(
          child: Text(pressed ? langValue : langKey,
              style: TextStyle(fontSize: 50, fontFamily: 'monospace')),
          onPressed: () {
            setState(() {
              pressed = !pressed;
            });
          },
          onLongPress: () {},
          textColor: Colors.red,
          splashColor: Colors.red,
          colorBrightness: Brightness.dark,
          shape: Border.all(width: 2.0, color: Colors.redAccent),
          height: 80,
          minWidth: 200),
    );
  }
}

class WordButton extends StatefulWidget {
  @override
  WordButtonState createState() => WordButtonState();
}
