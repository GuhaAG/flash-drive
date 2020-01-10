import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'word_button.dart';

class FlashDriveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('FLash-Drive'),
      ),
      body: WordButton(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          wordPair.clear();
          File file = await FilePicker.getFile(
              type: FileType.CUSTOM, fileExtension: 'txt');
          Stream<List<int>> inputStream = file.openRead();
          inputStream
              .transform(utf8.decoder) // Decode bytes to UTF-8.
              .transform(
                  new LineSplitter()) // Convert stream to individual lines.
              .listen((String line) {
            loadWordPairs('$line'); // Process results.
          }, onDone: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.redAccent,
                    title: new Text('Your words are locked & loaded !'),
                    content: new Text(
                        'TAP button to learn the meaning / LONG PRESS to cycle to the next word'),
                  );
                });
          }, onError: (e) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    title: new Icon(Icons.error),
                    content: new Text(e.toString()),
                  );
                });
          });
        },
        child: Icon(Icons.file_upload),
        backgroundColor: Colors.redAccent,
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
