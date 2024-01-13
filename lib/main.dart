/// Pieter Dyason
/// GitHub @pdyason
/// Apache 2.0 License

import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/app/utils.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/store.dart';
import 'package:wallet/data/repositories/asset_data.dart';
import 'app/app.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  runZonedGuarded(
    () async {
      // initialize Redux store
      final store = AppStore.init();

      // Catch Sync Errors - Function - Always catches the error, before drawing it
      FlutterError.onError = _handleFlutterOnError;

      // Catch Sync Errors - Builder - Overrides error draw screen
      ErrorWidget.builder = _handleErrorWidgetBuilder;

      // Initialize WidgetsFlutterBinding
      WidgetsFlutterBinding.ensureInitialized();

      // load saved data
      store.dispatch(LoadSavedData());

      // load asset data into memory to improve responsiveness
      unawaited(AssetData.loadAssetDataIntoMemory());

      // Platform specific settings
      await _setupPlatforms();

      // run flutter app
      if (kIsWeb) {
        runApp(Center(child: SizedBox(height: 700, width: 400, child: App(store))));
      } else {
        runApp(App(store));
      }
    },
    // Catch Async Errors - Rest of app continues normally - Would normally kill the program
    _handleAsyncErrors,
  );
}

Future<void> _setupPlatforms() async {
  // set portrait mode
  if (!kIsWeb) {
    if (!io.Platform.isAndroid || io.Platform.isIOS) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }
  // set global android status bar color - carter for pages without appBar
  if (!kIsWeb) {
    if (io.Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
  }
}

void _handleAsyncErrors(error, stack) {
  debug('Error Caught by runZonedGuarded \n $error \n $stack', isError: true);
}

Widget _handleErrorWidgetBuilder(FlutterErrorDetails details) {
  debug('Error Caught by ErrorWidget.builder \n ${details.exception}', isError: true);
  return const MyErrorPage('Default: Caught by ErrorWidget.builder');
}

void _handleFlutterOnError(FlutterErrorDetails details) {
  debug('Error Caught by FlutterError.onError \n ${details.exception}', isError: true);
}

class MyErrorPage extends StatelessWidget {
  final String errorMsg;
  const MyErrorPage(this.errorMsg, {super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Error Page')),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Text(errorMsg),
          ),
        ),
      ),
    );
  }
}
