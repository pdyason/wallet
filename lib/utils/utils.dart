// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';

void printList(List list) {
  for (var obj in (list)) {
    debug(obj);
  }
}

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
