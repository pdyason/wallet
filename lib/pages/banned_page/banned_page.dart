import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallet/app/constants.dart';
import 'package:wallet/app/styles.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/state.dart';
import 'package:wallet/pages/banned_page/country_picker.dart';

import 'package:wallet/pages/banned_page/country_tile.dart';

class BannedPage extends StatelessWidget {
  const BannedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.listBackgroundColor,
      appBar: AppBar(
        backgroundColor: Styles.listBackgroundColor,
        title: const Text('Banned Countries'),
        actions: [
          IconButton(
            onPressed: () => _showCountryPicker(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const BannedView(),
    );
  }

  void _showCountryPicker(BuildContext context) {
    var state = StoreProvider.of<AppState>(context).state;
    var availableCountries = Constants.allCountries.toSet().difference(state.bannedCountries.toSet()).toList();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Styles.listBackgroundColor,
          title: const Text('Select a Country'),
          content: CountryPicker(
            countries: availableCountries,
            onCountrySelected: (country) {
              StoreProvider.of<AppState>(context).dispatch(AddBannedCountry(country));
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

class BannedView extends StatelessWidget {
  const BannedView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Styles.listBackgroundColor,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [...state.bannedCountries.map((c) => CountryTile(c)).toList()],
          ),
        );
      },
    );
  }
}
