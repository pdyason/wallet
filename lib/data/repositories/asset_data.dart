import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wallet/data/models/bank_card_type.dart';

// use static class and load data into memory for future requests
class AssetData {
  static List<BankCardType>? issuerTypes;
  static String? readme;

  static Future<Map<String, dynamic>> _parseJsonFromAssets(String assetsPath) async {
    return jsonDecode((await rootBundle.loadString(assetsPath)));
  }

  static Future<void> loadAssetDataIntoMemory() async {
    getIssuerTypes();
    getReadme();
  }

  static Future<List<BankCardType>> getIssuerTypes() async {
    if (issuerTypes != null) return issuerTypes!;
    issuerTypes = ((await _parseJsonFromAssets('assets/data/card_issuer_types.json'))["types"] as List)
        .map((type) => BankCardType.fromJson(type))
        .toList();
    return issuerTypes!;
  }

  static Future<String> getReadme() async {
    if (readme != null) return readme!;
    readme = await rootBundle.loadString('assets/data/readme.md');
    return readme!;
  }
}
