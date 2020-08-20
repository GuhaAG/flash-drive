import 'package:flutter/material.dart';
import 'src/flash_drive_app.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() => runApp(Phoenix(
    child: new MaterialApp(title: 'flash-drive', home: new FlashDriveApp())));
