import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/state.dart';
import 'package:wallet/data/repositories/asset_data.dart';
import 'package:wallet/data/repositories/shared_prefs.dart';
import 'package:redux/redux.dart';
import 'package:wallet/utils/utils.dart';

// print action before sending it on
void loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  debug('++ Action: $action');
  next(action);
}

// map actions to functions
void appStateMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
  next(action);
  switch (action.runtimeType) {
    case RemoveAllCards:
      _removeAllCards(store);
    case AddCard:
      _addCard(store, action);
    case RemoveCard:
      _removeCard(store, action);
    case UpdateCardlist:
      await _updateCardList(store, action);
    case AddBannedCountry:
      _addBannedCountry(store, action);
    case RemoveBannedCountry:
      _removeBannedCountry(store, action);
    case UpdateBannedList:
      await _updateBannedList(store, action);
    case LoadSampleData:
      await _loadSampleData(store);
    case LoadSharedPrefs:
      await _loadSharedPrefs(store);
  }
}

Future<void> _loadSampleData(Store<AppState> store) async {
  store.dispatch(UpdateCardlist(await AssetData.getSampleCards()));
  store.dispatch(UpdateBannedList(await AssetData.getSampleBannedCountries()));
}

Future<void> _loadSharedPrefs(Store<AppState> store) async {
  store.dispatch(UpdateCardlist(await SharedPrefs.fetchCardList()));
  store.dispatch(UpdateBannedList(await SharedPrefs.fetchBannedList()));
}

Future<void> _updateCardList(Store<AppState> store, UpdateCardlist action) async {
  await SharedPrefs.saveCardList(action.cards);
}

Future<void> _updateBannedList(Store<AppState> store, UpdateBannedList action) async {
  await SharedPrefs.saveBannedList(action.bannedCountries);
}

void _removeAllCards(Store<AppState> store) {
  store.dispatch(UpdateCardlist([]));
}

void _addCard(Store<AppState> store, AddCard action) {
  // check if card already exists
  if (store.state.cards.contains(action.card)) return;
  store.dispatch(UpdateCardlist(List.from(store.state.cards)..add(action.card)));
}

void _removeCard(Store<AppState> store, RemoveCard action) {
  store.dispatch(UpdateCardlist(List.from(store.state.cards)..removeWhere((c) => c.number == action.card.number)));
}

void _addBannedCountry(Store<AppState> store, AddBannedCountry action) {
  // check if country already exists
  if (store.state.bannedCountries.contains(action.country)) return;
  store.dispatch(UpdateBannedList(List.from(store.state.bannedCountries)..add(action.country)));
}

void _removeBannedCountry(Store<AppState> store, RemoveBannedCountry action) {
  store.dispatch(UpdateBannedList(List.from(store.state.bannedCountries)..removeWhere((c) => c == action.country)));
}
