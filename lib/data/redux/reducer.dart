import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/state.dart';
import 'package:wallet/app/utils.dart';

// return a new state
AppState reducer(AppState state, dynamic action) {
  AppState newState(AppState newState) {
    // print new state if changed
    if (newState != state) {
      debug('== State:  $action  >  '
          'cards:${newState.cards.length}  '
          'new:${newState.newCards.length}  '
          'banned:${newState.bannedCountries.length}');
    } else {
      debug('== State Unchanged ==');
    }
    return newState;
  }

  // reduce actions that alter the state
  if (action is CardListUpdated) {
    return newState(state.copyWith(cards: action.cards, newCards: action.newCards));
  }
  if (action is BannedListUpdated) {
    List<String> newList = action.bannedCountries;
    newList.sort((a, b) => a.compareTo(b));
    return newState(state.copyWith(bannedCountries: newList));
  }

  // all actions are expected to be handled by middleware or the reducer
  // provision is added to ignore certian actions
  List<Type> ignoreActions = [];
  if (!ignoreActions.contains(action.runtimeType)) {
    assert(false, "Unhandled Action in Reducer: ${action.runtimeType}");
  }

  // if action is not handled return a copy of the previous state
  return newState(state.copyWith());
}
