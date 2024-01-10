// Use this file for tests
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/middleware.dart';
import 'package:wallet/data/redux/reducer.dart';
import 'package:wallet/data/redux/state.dart';

class AppStore {
  static Store<AppState> init() {
    final middleware = <Middleware<AppState>>[loggingMiddleware, appStateMiddleware];
    final store = Store<AppState>(
      reducer,
      initialState: AppState.initial(),
      middleware: middleware,
    );
    return store;
  }

  static Future<Store<AppState>> testInit() async {
    final middleware = <Middleware<AppState>>[loggingMiddleware, appStateMiddleware];
    final store = Store<AppState>(
      reducer,
      initialState: AppState.initial(),
      middleware: middleware,
    );

    WidgetsFlutterBinding.ensureInitialized();
    store.dispatch(LoadSavedData());
    await Future.delayed(const Duration(milliseconds: 500));
    return store;
  }
}
