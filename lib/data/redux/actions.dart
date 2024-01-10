import 'package:wallet/data/models/bank_card.dart';
import 'package:wallet/data/redux/state.dart';

sealed class AppAction {}

// class Undo extends AppAction {
//   final AppState prevState;

//   Undo(this.prevState);
//   @override
//   String toString() => 'Undo';
// }

class SetAppState extends AppAction {
  final AppState newState;

  SetAppState(this.newState);
  @override
  String toString() => 'SetAppState';
}

class LoadSampleCard extends AppAction {
  @override
  String toString() => 'LoadSampleCard';
}

class LoadSavedData extends AppAction {
  @override
  String toString() => 'LoadSavedData';
}

class UpdateCardList extends AppAction {
  final List<BankCard> cards;
  UpdateCardList(this.cards);
  @override
  String toString() => 'UpdateCardList';
}

class UpdateNewCardList extends AppAction {
  final List<BankCard> newCards;
  UpdateNewCardList(this.newCards);
  @override
  String toString() => 'UpdateNewCardList';
}

class CardListUpdated extends AppAction {
  final List<BankCard> cards;
  CardListUpdated(this.cards);
  @override
  String toString() => 'CardListUpdated';
}

class NewCardListUpdated extends AppAction {
  final List<BankCard> newCards;
  NewCardListUpdated(this.newCards);
  @override
  String toString() => 'NewCardListUpdated';
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
