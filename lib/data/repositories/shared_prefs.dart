import 'package:wallet/data/models/bank_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefs {
  static Future<void> saveCardList(List<BankCard> cards) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('CardList', cards.map((c) => jsonEncode(c.toJson())).toList());
  }

  static Future<List<BankCard>> fetchCardList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cards = prefs.getStringList('CardList') ?? [];
    return cards.map((c) => BankCard.fromJson(jsonDecode(c))).toList();
  }

  static Future<void> saveBannedList(List<String> banned) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('BannedList', banned);
  }

  static Future<List<String>> fetchBannedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> banned = prefs.getStringList('BannedList') ?? [];
    return banned;
  }
}
