import 'package:flutter/material.dart';

List<Map<String, String>> wordPair = [
  {'key': 'gracias', 'value': 'thanks'}
];

class WordButton extends StatefulWidget {
  @override
  WordButtonState createState() => WordButtonState();
}

class WordButtonState extends State<WordButton> {
  bool pressed = false;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    String langKey = wordPair[i]['key'];
    String langValue = wordPair[i]['value'];

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          MaterialButton(
              child: Text(pressed ? langValue : langKey,
                  style: TextStyle(fontSize: 50, fontFamily: 'monospace')),
              onPressed: () {
                setState(() {
                  pressed = !pressed;
                });
              },
              onLongPress: () {
                setState(() {
                  pressed = false;
                  i = i == wordPair.length - 1 ? 0 : i + 1;
                });
              },
              textColor: Colors.red,
              splashColor: Colors.red,
              colorBrightness: Brightness.dark,
              shape: Border.all(width: 2.0, color: Colors.redAccent),
              height: 80,
              minWidth: 200)
        ]));
  }
}
