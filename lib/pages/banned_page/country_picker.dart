import 'package:flutter/material.dart';

class CountryPicker extends StatelessWidget {
  final Function(String) onCountrySelected;
  final List<String> countries;
  const CountryPicker({super.key, required this.countries, required this.onCountrySelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(countries[index]),
            onTap: () => onCountrySelected(countries[index]),
          );
        },
      ),
    );
  }
}
