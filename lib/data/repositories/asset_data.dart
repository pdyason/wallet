import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wallet/data/models/bank_card.dart';
import 'package:wallet/data/models/bank_card_type.dart';

// use static class and load data into memory for future requests
class AssetData {
  static List<BankCard>? sampleCards;
  static List<String>? sampleBannedCountries;
  static String? readme;
  static List<BankCardType>? issuerTypes;

  static Future<Map<String, dynamic>> _parseJsonFromAssets(String assetsPath) async {
    return jsonDecode((await rootBundle.loadString(assetsPath)));
  }

  static Future<List<BankCard>> getSampleCards() async {
    if (sampleCards != null) return sampleCards!;
    sampleCards =
        ((await _parseJsonFromAssets('assets/data/sample_data/sample_cards.json'))["sample_verified_cards"] as List)
            .map((card) => BankCard.fromJson(card))
            .toList();
    return sampleCards!;
  }

  static Future<String> getReadme() async {
    if (readme != null) return readme!;
    readme = await rootBundle.loadString('assets/data/readme.md');
    return readme!;
  }

  static Future<List<String>> getSampleBannedCountries() async {
    if (sampleBannedCountries != null) return sampleBannedCountries!;
    sampleBannedCountries =
        ((await _parseJsonFromAssets('assets/data/sample_data/sample_banned_countries.json'))["sample_banned_countries"]
                as List)
            .map((c) => c.toString())
            .toList();
    return sampleBannedCountries!;
  }

  static Future<List<BankCardType>> getIssuerTypes() async {
    if (issuerTypes != null) return issuerTypes!;
    issuerTypes = ((await _parseJsonFromAssets('assets/data/card_types/card_issuer_types.json'))["types"] as List)
        .map((type) => BankCardType.fromJson(type))
        .toList();
    return issuerTypes!;
  }
}
