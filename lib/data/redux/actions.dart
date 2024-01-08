import 'package:wallet/data/models/bank_card.dart';

sealed class AppAction {}

class RemoveAllCards extends AppAction {
  @override
  String toString() => 'RemoveAllCards';
}

class LoadSampleData extends AppAction {
  @override
  String toString() => 'LoadSampleData';
}

class LoadSharedPrefs extends AppAction {
  @override
  String toString() => 'LoadSharedPrefs';
}

class UpdateCardlist extends AppAction {
  final List<BankCard> cards;
  UpdateCardlist(this.cards);
  @override
  String toString() => 'UpdateCardList';
}

class UpdateAllCountryList extends AppAction {
  final List<String> allCountries;
  UpdateAllCountryList(this.allCountries);
  @override
  String toString() => 'PopulateAllCountries';
}

class UpdateBannedList extends AppAction {
  final List<String> bannedCountries;
  UpdateBannedList(this.bannedCountries);
  @override
  String toString() => 'UpdateBannedList';
}

class AddCard extends AppAction {
  final BankCard card;
  AddCard(this.card);
  @override
  String toString() => 'AddCard';
}

class RemoveCard extends AppAction {
  final BankCard card;
  RemoveCard(this.card);
  @override
  String toString() => 'RemoveCard';
}

class AddBannedCountry extends AppAction {
  final String country;
  AddBannedCountry(this.country);
  @override
  String toString() => 'AddBannedCountry';
}

class RemoveBannedCountry extends AppAction {
  final String country;
  RemoveBannedCountry(this.country);
  @override
  String toString() => 'RemoveBannedCountry';
}
