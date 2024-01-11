import 'package:flutter/foundation.dart';
import 'package:wallet/data/models/bank_card.dart';
import 'package:wallet/data/redux/state.dart';

sealed class AppAction {}

class SetAppState extends AppAction {
  final AppState newState;

  SetAppState(this.newState);
  @override
  String toString() => 'SetAppState';
}

class CatchException extends AppAction {
  final Object e;

  CatchException(this.e);
  @override
  String toString() => 'CatchException';
}

class AddSampleCard extends AppAction {
  final VoidCallback? onAdded;
  AddSampleCard({this.onAdded});
  @override
  String toString() => 'AddSampleCard';
}

class LoadSavedData extends AppAction {
  @override
  String toString() => 'LoadSavedData';
}

class UpdateCardList extends AppAction {
  final List<BankCard> cards;
  final List<BankCard> newCards;
  UpdateCardList({required this.cards, required this.newCards});
  @override
  String toString() => 'UpdateCardList';
}

class CardListUpdated extends AppAction {
  final List<BankCard> cards;
  final List<BankCard> newCards;
  CardListUpdated({required this.cards, required this.newCards});
  @override
  String toString() => 'CardListUpdated';
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

class BannedListUpdated extends AppAction {
  final List<String> bannedCountries;
  BannedListUpdated(this.bannedCountries);
  @override
  String toString() => 'BannedListUpdated';
}

class AddCard extends AppAction {
  final BankCard card;
  AddCard(this.card);
  @override
  String toString() => 'AddCard';
}

class RemoveCard extends AppAction {
  final BankCard card;
  final VoidCallback? onRemoved;
  RemoveCard(this.card, {this.onRemoved});
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
  final VoidCallback? onRemoved;
  RemoveBannedCountry(this.country, {this.onRemoved});
  @override
  String toString() => 'RemoveBannedCountry';
}
