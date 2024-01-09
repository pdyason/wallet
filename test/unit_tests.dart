// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';

// import 'package:wallet/main.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallet/data/repositories/asset_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('Readme', () async {
    var readme = await AssetData.getReadme();
    expect(readme.isNotEmpty, true);
  });

  // test('Saved Cards', () async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   var savedCards = await SharedPrefs.saveCardList([]);
  //   // expect(savedCards == null, false);
  //   // printList(savedCards);
  // });
}
