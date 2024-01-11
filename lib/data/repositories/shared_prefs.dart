import 'package:wallet/data/models/bank_card.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPrefs {
  static const androidOptions = AndroidOptions(encryptedSharedPreferences: true);
  static const storage = FlutterSecureStorage(aOptions: androidOptions);

  static Future<void> saveCardList(List<BankCard> cards) async {
    await storage.write(
      key: 'CardList',
      value: jsonEncode(cards.map((c) => jsonEncode(c.toJson())).toList()),
    );
  }

  static Future<List<BankCard>> fetchCardList() async {
    var jsonStr = await storage.read(key: 'CardList');
    List<String> cards = jsonStr != null ? jsonDecode(jsonStr).cast<String>() : [];
    return cards.map((c) => BankCard.fromJson(jsonDecode(c))).toList();
  }

  static Future<void> saveBannedList(List<String> banned) async {
    await storage.write(
      key: 'BannedList',
      value: jsonEncode(banned),
    );
  }

  static Future<List<String>> fetchBannedList() async {
    var jsonStr = await storage.read(key: 'BannedList');
    List<String> banned = jsonStr != null ? jsonDecode(jsonStr).cast<String>() : [];
    return banned;
  }
}
