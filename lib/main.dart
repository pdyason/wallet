import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/middleware.dart';
import 'package:wallet/data/redux/reducer.dart';
import 'package:wallet/data/redux/state.dart';
import 'app.dart';

// TODO add comments
// TODO add tests
// TODO add basic encryption
// TODO wait for loads to finish

void main() async {
  // Redux
  final middleware = <Middleware<AppState>>[loggingMiddleware, appStateMiddleware];
  final store = Store<AppState>(
    reducer,
    initialState: AppState.initial(),
    middleware: middleware,
  );

  WidgetsFlutterBinding.ensureInitialized();

  store.dispatch(LoadSharedPrefs());

  if (Platform.isAndroid || Platform.isIOS) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  runApp(App(store));
}
