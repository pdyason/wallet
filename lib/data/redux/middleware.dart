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

// print exception
void catchExceptionMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is CatchException) {
    debug('!! Exception: $action', isError: true);
  } else {
    next(action);
  }
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
    case AddSampleCard:
      _addSampleCard(store, action);
    // Saved
    case LoadSavedData:
      _loadSavedData(store); // unawaited
    default:
      next(action);
  }
}

_addSampleCard(Store<AppState> store, AddSampleCard action) {
  store.dispatch(AddCard(BankCard.sample()));
  action.onAdded?.call();
}

_loadSavedData(Store<AppState> store) async {
  try {
    store.dispatch(UpdateCardList(cards: await SharedPrefs.fetchCardList(), newCards: []));
    store.dispatch(UpdateBannedList(await SharedPrefs.fetchBannedList()));
  } catch (e) {
    store.dispatch(CatchException(e));
  }
}

_updateCardList(Store<AppState> store, UpdateCardList action) async {
  try {
    await SharedPrefs.saveCardList(action.cards);
    store.dispatch(CardListUpdated(cards: action.cards, newCards: action.newCards));
  } catch (e) {
    store.dispatch(CatchException(e));
  }
}

_updateBannedList(Store<AppState> store, UpdateBannedList action) async {
  try {
    await SharedPrefs.saveBannedList(action.bannedCountries);
    store.dispatch(BannedListUpdated(action.bannedCountries));
  } catch (e) {
    store.dispatch(CatchException(e));
  }
}

_addCard(Store<AppState> store, AddCard action) {
  // ignore if card already exists
  if (store.state.cards.map((c) => c.number).toList().contains(action.card.number)) return;
  store.dispatch(UpdateCardList(
    cards: List.from(store.state.cards)..add(action.card),
    newCards: List.from(store.state.newCards)..add(action.card),
  ));
}

_removeCard(Store<AppState> store, RemoveCard action) async {
  store.dispatch(UpdateCardList(
    cards: List.from(store.state.cards)..removeWhere((c) => c.number == action.card.number),
    newCards: List.from(store.state.newCards)..removeWhere((c) => c.number == action.card.number),
  ));
  action.onRemoved?.call();
}

_addBannedCountry(Store<AppState> store, AddBannedCountry action) {
  // check if country already exists
  if (store.state.bannedCountries.contains(action.country)) return;
  store.dispatch(UpdateBannedList(List.from(store.state.bannedCountries)..add(action.country)));
}

_removeBannedCountry(Store<AppState> store, RemoveBannedCountry action) {
  store.dispatch(UpdateBannedList(List.from(store.state.bannedCountries)..removeWhere((c) => c == action.country)));
  action.onRemoved?.call();
}

_setAppState(Store<AppState> store, SetAppState action) {
  store.dispatch(UpdateBannedList(List.from(action.newState.bannedCountries)));
  store.dispatch(UpdateCardList(
    cards: List.from(action.newState.cards),
    newCards: List.from(action.newState.newCards),
  ));
}
