/// Pieter Dyason
/// GitHub @pdyason
/// Apache 2.0 License

import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/store.dart';
import 'package:wallet/data/repositories/asset_data.dart';
import 'app/app.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  // initialize Redux store
  final store = AppStore.init();

  // initialize Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  // load saved data
  store.dispatch(LoadSavedData());

  // load asset data into memory to improve responsiveness
  unawaited(AssetData.loadAssetDataIntoMemory());

  // run flutter app
  if (kIsWeb) {
    // run flutter app for web
    runApp(Center(child: SizedBox(height: 700, width: 400, child: App(store))));
  } else {
    // set portrait mode
    if (io.Platform.isAndroid || io.Platform.isIOS) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    // set global android status bar color - carter for pages without appBar
    if (io.Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
    // run flutter app for mobile
    runApp(App(store));
  }
}
