import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallet/app/constants.dart';
import 'package:wallet/app/styles.dart';
import 'package:wallet/app/utils.dart';
import 'package:wallet/data/models/bank_card.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/state.dart';

class NewCardPage extends StatelessWidget {
  const NewCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Styles.listBackgroundColor,
            appBar: AppBar(
              title: const Text('Add Bank Card'),
              backgroundColor: Styles.listBackgroundColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: NewCardForm(state: state),
            ),
          );
        });
  }
}

class NewCardForm extends StatefulWidget {
  final AppState state;
  const NewCardForm({required this.state, super.key});
  @override
  State<NewCardForm> createState() => _NewCardFormState();
}

class _NewCardFormState extends State<NewCardForm> {
  late final List<String> availableCountries;
  late final List<String> existingCards;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _ccvController = TextEditingController();
  String? _selectedCountry;

  @override
  void initState() {
    super.initState();
    availableCountries = Constants.allCountries.toSet().difference(widget.state.bannedCountries.toSet()).toList();
    existingCards = widget.state.cards.map((c) => c.number).toList();
  }

  // TODO add to validations

  String? _validateCCV(String? value) {
    if (value == null || value.length != 3 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Enter a valid 3 digit CCV';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value == null || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Enter a valid bank card number';
    } else if (existingCards.contains(value)) {
      return 'This card has already add been added';
    }
    return null;
  }

  String? _validateAlias(String? value) {
    if (value == null || value.length > 10) {
      return 'Maximum 10 characters';
    }
    return null;
  }

  String? _validateCountry(value) {
    if (value == null || value.isEmpty || !availableCountries.contains(value)) {
      return 'Select a country';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildScanButton(),
            const SizedBox(height: 20),
            _buildAlias(),
            _buildNumber(),
            _buildCCV(),
            _buildCountry(),
            const SizedBox(height: 20),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  _scanCard() async {
    try {
      Map<String, String>? cardDetails = await Utils.scanCard();
      if (cardDetails != null) {
        _numberController.text = cardDetails['cardNumber'].toString();
        _aliasController.text = cardDetails['cardHolderName'].toString();
      }
    } catch (e) {
      debug('Scanning card failed: $e');
    }
  }

  Widget _buildScanButton() {
    return ElevatedButton(
      onPressed: () => _scanCard(),
      child: const SizedBox(
        width: 200.0,
        height: 50.0,
        child: Center(
          child: Text(
            'Click to Scan Card',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> _buildCountry() {
    return DropdownButtonFormField<String>(
      value: _selectedCountry,
      onChanged: (value) {
        setState(() {
          _selectedCountry = value;
        });
      },
      items: availableCountries.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: const InputDecoration(labelText: 'Select a country'),
      validator: _validateCountry,
    );
  }

  ElevatedButton _buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          debug('Alias:   ${_aliasController.text}');
          debug('Number:  ${_numberController.text}');
          debug('CCV:     ${_ccvController.text}');
          debug('Country: $_selectedCountry');
          StoreProvider.of<AppState>(context).dispatch(
            AddCard(
              BankCard(
                alias: _aliasController.text,
                number: _numberController.text,
                ccv: _ccvController.text,
                country: _selectedCountry ?? '',
                type: 'Bank Card',
              ),
            ),
          );
          Navigator.pop(context);
        }
      },
      child: const Text('Confirm'),
    );
  }

  TextFormField _buildAlias() {
    return TextFormField(
      controller: _aliasController,
      decoration: const InputDecoration(
        labelText: 'Enter Alias (Optional)',
      ),
      keyboardType: TextInputType.number,
      validator: _validateAlias,
    );
  }

  TextFormField _buildCCV() {
    return TextFormField(
      controller: _ccvController,
      decoration: const InputDecoration(
        labelText: 'Enter CCV',
      ),
      keyboardType: TextInputType.number,
      validator: _validateCCV,
    );
  }

  TextFormField _buildNumber() {
    return TextFormField(
      controller: _numberController,
      decoration: const InputDecoration(
        labelText: 'Enter Number',
      ),
      keyboardType: TextInputType.number,
      validator: _validateNumber,
    );
  }
}
