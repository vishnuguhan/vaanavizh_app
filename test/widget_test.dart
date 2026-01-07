import 'package:flutter_test/flutter_test.dart';
import 'package:vaanavizh_app/main.dart';

void main() {
  testWidgets('VaanAvizh app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VaanavizhApp());

    // Verify that the app starts without crashing
    expect(find.byType(VaanavizhApp), findsOneWidget);
  });
}
