import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallet/configs/constants.dart';
import 'package:wallet/data/redux/state.dart';
import 'package:wallet/pages/wallet_page/wallet_page.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  final Store<AppState> store;
  const App(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.brown,
            brightness: Brightness.light,
          ),
        ),
        title: Constants.appName,
        debugShowCheckedModeBanner: false,
        home: const WalletPage(),
      ),
    );
  }
}
