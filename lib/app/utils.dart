// ignore_for_file: avoid_print
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:flutter/foundation.dart';

void debug(dynamic value) {
  if (kDebugMode) {
    // if (kDebugMode || true) {
    try {
      // print yello
      print('\x1B[33m$value\x1B[0m');
    } catch (e) {
      // print red
      print('\x1B[31m$e\x1B[0m');
    }
  }
}

class Utils {
  static Future<Map<String, String>?> scanCard() async {
    var cardDetails = await CardScanner.scanCard(
      scanOptions: const CardScanOptions(scanCardHolderName: true),
    );
    return cardDetails?.map; // {cardNumber:, cardHolderName: }
  }

  static String formatBankCardNumber(String creditCardNumber) {
    // Remove any existing spaces or non-digit characters
    creditCardNumber = creditCardNumber.replaceAll(RegExp(r'\D'), '');
    // Add sapces after every 4 digits
    List<String> chunks = [];
    for (int i = 0; i < creditCardNumber.length; i += 4) {
      chunks.add(creditCardNumber.substring(i, i + 4));
    }
    String formattedNumber = chunks.join(' ');
    return formattedNumber;
  }

  static void printList(List list) {
    for (var obj in (list)) {
      debug(obj);
    }
  }
}
