import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'card_page.dart';

class FlashDriveApp extends StatefulWidget {
  @override
  FlashDriveState createState() {
    return new FlashDriveState();
  }
}

class FlashDriveState extends State<FlashDriveApp> {
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('flash-drive'),
      ),
      body: CardPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          wordPair.clear();
          File file = await FilePicker.getFile(
              type: FileType.custom, allowedExtensions: ['txt', 'doc', 'docx']);
          Stream<List<int>> inputStream = file.openRead();
          inputStream
              .transform(utf8.decoder) // Decode bytes to UTF-8.
              .transform(
                  new LineSplitter()) // Convert stream to individual lines.
              .listen((String line) {
            loadWordPairs('$line'); // Process results.
          }, onDone: () {
            setState(() {
              loaded = true;
            });
            if (!error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.amberAccent,
                      title: new Text(
                          "Your flash cards are ready\n\n Happy Studying !"),
                      content: new Text("Tap anywhere to close"),
                    );
                  });
            }
          }, onError: (e) {
            setState(() {
              error = true;
              loaded = false;
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.redAccent,
                    title: new Icon(Icons.error),
                    content: new Text(
                        "File content is invalid\n\nPlease use a file with comma separated text on each line."),
                  );
                }).whenComplete(() => {Phoenix.rebirth(context)});
          });
        },
        child: Icon(Icons.file_upload),
        backgroundColor: Colors.amberAccent,
      ),
    );
  }

  loadWordPairs(String s) {
    Map<String, String> wordPairMap = {
      'key': s.split(',')[0].trim(),
      'value': s.split(',')[1].trim()
    };
    wordPair.add(wordPairMap);
  }
}
