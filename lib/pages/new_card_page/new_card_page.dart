import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallet/app/constants.dart';
import 'package:wallet/app/styles.dart';
import 'package:wallet/app/utils.dart';
import 'package:wallet/data/models/bank_card.dart';
import 'package:wallet/data/models/bank_card_type.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/state.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:wallet/data/repositories/asset_data.dart';

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
              child: NewCardForm(
                existingCardNumbers: state.cards.map((c) => c.number).toList(),
                availableCountries: Constants.allCountries.toSet().difference(state.bannedCountries.toSet()).toList(),
              ),
            ),
          );
        });
  }
}

class NewCardForm extends StatefulWidget {
  final List<String> existingCardNumbers;
  final List<String> availableCountries;
  const NewCardForm({
    required this.existingCardNumbers,
    required this.availableCountries,
    super.key,
  });
  @override
  State<NewCardForm> createState() => _NewCardFormState();
}

class _NewCardFormState extends State<NewCardForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _ccvController = TextEditingController();
  String? _selectedCountry;

  @override
  void initState() {
    super.initState();
    // listen to card number changes
    _numberController.addListener(_onCardNumberChanged);
  }

  Future<void> _onCardNumberChanged() async {
    // only check for type if length is > 10
    if (_numberController.text.length > 10) {
      List<BankCardType> types = await AssetData.getIssuerTypes();
      for (var type in types) {
        if (type.lengths.contains(_numberController.text.length)) {
          for (var prefix in type.getPrefixes()) {
            if (_numberController.text.startsWith(prefix)) {
              _typeController.text = type.type;
              return;
            }
          }
        }
      }
    }
  }

  String? _validateAlias(String? value) {
    if (value == null || value.length > 10) {
      return 'Maximum 10 characters';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value == null || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Enter a valid bank card number';
    } else if (widget.existingCardNumbers.contains(value)) {
      return 'This card has already add been added';
    } else if (!Utils.isCardNumberValid(value)) {
      return 'Invalid card number (Luhn)';
    }
    return null;
  }

  String? _validateType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter a card issuer (Visa)';
    } else if (value.length > 15) {
      return 'Maximum 15 characters';
    }
    return null;
  }

  String? _validateCCV(String? value) {
    if (value == null || value.length != 3 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Enter a valid 3 digit CCV';
    }
    return null;
  }

  String? _validateCountry(value) {
    if (value == null || value.isEmpty) {
      return 'Select a Country';
    } else if (!widget.availableCountries.contains(value)) {
      return 'Cards from this country are not allowed';
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
            if (kIsWeb) _buildEnterCardLabel(),
            if (!kIsWeb) _buildScanButton(),
            const SizedBox(height: 20),
            _buildAlias(),
            _buildNumber(),
            _buildType(),
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

  Widget _buildEnterCardLabel() {
    return Container(
      width: 200.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Styles.cardBackgroundColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Styles.cardBorderColor),
      ),
      child: const Center(
        child: Text(
          'Enter Card Details',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
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

  TextFormField _buildAlias() {
    return TextFormField(
      controller: _aliasController,
      decoration: const InputDecoration(
        labelText: 'Enter Alias (Optional)',
      ),
      keyboardType: TextInputType.name,
      validator: _validateAlias,
    );
  }

  TextFormField _buildNumber() {
    return TextFormField(
      controller: _numberController,
      decoration: const InputDecoration(
        labelText: 'Enter Card Number',
      ),
      keyboardType: TextInputType.number,
      validator: _validateNumber,
    );
  }

  TextFormField _buildType() {
    return TextFormField(
      controller: _typeController,
      decoration: const InputDecoration(
        labelText: 'Enter Card Issuer',
      ),
      keyboardType: TextInputType.name,
      validator: _validateType,
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

  DropdownButtonFormField<String> _buildCountry() {
    return DropdownButtonFormField<String>(
      value: _selectedCountry,
      onChanged: (value) {
        setState(() {
          _selectedCountry = value;
        });
      },
      items: widget.availableCountries.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: const InputDecoration(labelText: 'Select a Country'),
      validator: _validateCountry,
    );
  }

  ElevatedButton _buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          StoreProvider.of<AppState>(context).dispatch(
            AddCard(
              BankCard(
                alias: _aliasController.text,
                number: _numberController.text,
                ccv: _ccvController.text,
                country: _selectedCountry ?? '',
                type: _typeController.text,
              ),
            ),
          );
          Navigator.pop(context);
        }
      },
      child: const Text('Confirm'),
    );
  }
}
