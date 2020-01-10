import 'package:flash_drive/src/flash_drive_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Trigger app frame', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(FlashDriveApp());
  });
}
