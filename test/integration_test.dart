import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallet/app/app.dart';
import 'package:wallet/app/globals.dart' as globals;
import 'package:wallet/data/redux/store.dart';

void main() {
  FlutterSecureStorage.setMockInitialValues({});
  globals.allowDebugPrints = false;

  testWidgets('Navigate to Add Bank Card Page', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(App((await AppStore.testInit())));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(find.text('Add Bank Card'), findsNothing, reason: 'Did not expect to find');
      await tester.tap(find.byIcon(Icons.add_card));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(find.text('Add Bank Card'), findsOne);
    });
  });

  testWidgets('Add Sample Card', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(App((await AppStore.testInit())));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.text('Add Sample Card'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(find.text('4242 4242 4242 4242'), findsOne);
    });
  });
}
