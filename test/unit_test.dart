import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallet/app/utils.dart';
import 'package:wallet/data/models/bank_card_type.dart';
import 'package:wallet/data/repositories/asset_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('Readme', () async {
    var readme = await AssetData.getReadme();
    expect(readme.isNotEmpty, true);
  });

  test('isCardNumberValid', () async {
    expect(Utils.isCardNumberValid('4574487405351567'), true);
    expect(Utils.isCardNumberValid('5412751234123456'), false);
  });

  test('IssuerTypes', () async {
    List<BankCardType> types = await AssetData.getIssuerTypes();
    expect(types.where((t) => t.type == 'Visa').toList().length == 1, true);
    BankCardType dc = types.firstWhere((t) => t.type == 'Diners Club');
    expect(dc.getPrefixes().length > 1, true);
  });
}
