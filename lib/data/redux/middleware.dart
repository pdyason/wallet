import 'package:wallet/data/models/bank_card.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/state.dart';
import 'package:wallet/data/repositories/shared_prefs.dart';
import 'package:redux/redux.dart';
import 'package:wallet/app/utils.dart';

// print action before sending it to next
void loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  debug('++ Action: $action');
  next(action);
}

// this middleware handles input actions and does not pass handled actions to next
void appStateMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
  switch (action.runtimeType) {
    // Cards
    case SetAppState:
      _setAppState(store, action);
    case AddCard:
      _addCard(store, action);
    case RemoveCard:
      _removeCard(store, action);
    case UpdateCardList:
      _updateCardList(store, action); // unawaited
    // Banned
    case AddBannedCountry:
      _addBannedCountry(store, action);
    case RemoveBannedCountry:
      _removeBannedCountry(store, action);
    case UpdateBannedList:
      _updateBannedList(store, action); // unawaited
    // Samples
    case LoadSampleCard:
      _loadSampleCard(store);
    // Saved
    case LoadSavedData:
      _loadSavedData(store); // unawaited
    default:
      next(action);
  }
}

_loadSampleCard(Store<AppState> store) {
  store.dispatch(AddCard(BankCard.sample()));
}

_loadSavedData(Store<AppState> store) async {
  store.dispatch(UpdateCardList(await SharedPrefs.fetchCardList()));
  store.dispatch(UpdateBannedList(await SharedPrefs.fetchBannedList()));
}

_updateCardList(Store<AppState> store, UpdateCardList action) async {
  await SharedPrefs.saveCardList(action.cards);
  store.dispatch(CardListUpdated(action.cards));
}

_updateBannedList(Store<AppState> store, UpdateBannedList action) async {
  await SharedPrefs.saveBannedList(action.bannedCountries);
  store.dispatch(BannedListUpdated(action.bannedCountries));
}

_addCard(Store<AppState> store, AddCard action) {
  // check if card already exists
  if (store.state.cards.map((c) => c.number).toList().contains(action.card.number)) return;
  // add to new cards list
  store.dispatch(NewCardListUpdated(List.from(store.state.newCards)..add(action.card)));
  store.dispatch(UpdateCardList(List.from(store.state.cards)..add(action.card)));
}

_removeCard(Store<AppState> store, RemoveCard action) {
  store.dispatch(
      NewCardListUpdated(List.from(store.state.newCards)..removeWhere((c) => c.number == action.card.number)));
  store.dispatch(UpdateCardList(List.from(store.state.cards)..removeWhere((c) => c.number == action.card.number)));
}

_addBannedCountry(Store<AppState> store, AddBannedCountry action) {
  // check if country already exists
  if (store.state.bannedCountries.contains(action.country)) return;
  store.dispatch(UpdateBannedList(List.from(store.state.bannedCountries)..add(action.country)));
}

_removeBannedCountry(Store<AppState> store, RemoveBannedCountry action) {
  store.dispatch(UpdateBannedList(List.from(store.state.bannedCountries)..removeWhere((c) => c == action.country)));
}

_setAppState(Store<AppState> store, SetAppState action) {
  store.dispatch(UpdateBannedList(List.from(action.newState.bannedCountries)));
  store.dispatch(UpdateCardList(List.from(action.newState.cards)));
  store.dispatch(NewCardListUpdated(List.from(action.newState.newCards)));
}
