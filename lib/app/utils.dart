import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:wallet/app/globals.dart' as globals;

// print debug messages
void debug(dynamic value) {
  if (kDebugMode && globals.allowDebugPrints) {
    try {
      // ignore: avoid_print
      print('\x1B[33m$value\x1B[0m'); // print yello
    } catch (e) {
      // ignore: avoid_print
      print('\x1B[31m$e\x1B[0m'); // print red
    }
  }
}

class Utils {
  // card scanner utility
  static Future<Map<String, String>?> scanCard() async {
    var cardDetails = await CardScanner.scanCard(
      scanOptions: const CardScanOptions(
        scanCardHolderName: true,
        enableLuhnCheck: true,
      ),
    );
    return cardDetails?.map; // {cardNumber:, cardHolderName: }
  }

  // format card number with spaces
  static String formatCardNumber(String creditCardNumber) {
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

  // luhn card number check
  static bool isCardNumberValid(String cardNumber) {
    List<int> cardDigits = cardNumber.split('').map(int.parse).toList();
    // Double every second digit from right to left
    for (int i = cardDigits.length - 2; i >= 0; i -= 2) {
      cardDigits[i] = (cardDigits[i] * 2 > 9) ? cardDigits[i] * 2 - 9 : cardDigits[i] * 2;
    }
    // Sum all the digits
    int total = cardDigits.reduce((a, b) => a + b);
    // Check if the total is divisible by 10
    return total % 10 == 0;
  }

  static void printList(List list) {
    for (var obj in (list)) {
      debug(obj);
    }
  }
}
