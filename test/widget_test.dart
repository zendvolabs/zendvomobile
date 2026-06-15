import 'package:flutter_test/flutter_test.dart';
import 'package:zendvo/main.dart';

void main() {
  testWidgets('App renders login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsWidgets);
  });
}
