/// Pieter Dyason
/// GitHub @pdyason
/// Apache 2.0 License

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/store.dart';
import 'app/app.dart';

// TODO infer card type *
// TODO action callbacks for alerts *
// TODO add basic encryption **
// TODO wait for loads to finish **

void main() async {
  // initialize Redux store
  final store = AppStore.init();

  // initialize Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  // load saved data //TODO
  store.dispatch(LoadSavedData());

  // set portrait mode
  if (Platform.isAndroid || Platform.isIOS) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // set global android status bar color - carter for pages without appBar
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  // run flutter app
  runApp(App(store));
}
