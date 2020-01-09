import 'package:flutter_test/flutter_test.dart';
import 'package:flash_drive/main.dart';

void main() {
  testWidgets('Trigger app frame', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(FlashDriveApp());
  });
}
