import 'dart:io';
import 'dart:convert';

import 'package:flash_drive/src/tutorial_overlay.dart';
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

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(TutorialOverlay());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('FlashDrive'),
        ),
        body: CardPage(),
        floatingActionButton: Row(
          children: [
            SizedBox(
              height: 0,
              width: 40,
            ),
            loaded
                ? FloatingActionButton(
                    onPressed: () => _showOverlay(context),
                    child: Icon(Icons.info),
                    backgroundColor: Colors.amberAccent,
                  )
                : SizedBox(
                    width: 55,
                  ),
            SizedBox(
              height: 0,
              width: 250,
            ),
            FloatingActionButton(
              onPressed: () async {
                wordPair.clear();
                File file = await FilePicker.getFile(
                    type: FileType.custom,
                    allowedExtensions: ['txt', 'doc', 'docx']);
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
                            title: new Text("Your flash cards are ready !"),
                            content: new Text("Let's go !"),
                          );
                        }).whenComplete(() => _showOverlay(context));
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
          ],
        ));
  }

  loadWordPairs(String s) {
    Map<String, String> wordPairMap = {
      'key': s.split(',')[0].trim(),
      'value': s.split(',')[1].trim()
    };
    wordPair.add(wordPairMap);
    //TODO: Add a settings page and choose to shuffle or not
    wordPair.shuffle();
  }
}
