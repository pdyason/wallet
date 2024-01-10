import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallet/data/models/bank_card.dart';
import 'package:wallet/pages/new_card_page/new_card_page.dart';
import 'package:wallet/pages/wallet_page/bank_card_tile.dart';

void main() {
  testWidgets('BankCardTile', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BankCardTile(
          card: BankCard.sample(),
          isNewlyAdded: true,
        ),
      ),
    );
    expect(find.text('4242 4242 4242 4242'), findsOne);
  });

  testWidgets('NewCardForm', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NewCardForm(
            existingCardNumbers: ['111', '222'],
            availableCountries: ['ZA', 'US'],
          ),
        ),
      ),
    );
    expect(find.text('Enter CCV'), findsOne);
    expect(find.text('Enter a valid 3 digit CCV'), findsNothing);
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.text('Enter a valid 3 digit CCV'), findsOne);
  });
}
