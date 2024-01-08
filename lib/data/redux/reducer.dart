import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/state.dart';
import 'package:wallet/utils/utils.dart';

// return a new state
AppState reducer(AppState state, dynamic action) {
  // print new state if changed
  AppState newState(AppState newState) {
    if (newState != state) {
      debug('== State:  $action  >  cards:${newState.cards.length}  banned:${newState.bannedCountries.length}');
    }
    return newState;
  }

  // reduce actions that alter the state
  if (action is UpdateCardlist) {
    return newState(state.copyWith(cards: action.cards));
  }
  if (action is UpdateBannedList) {
    List<String> newList = action.bannedCountries;
    newList.sort((a, b) => a.compareTo(b));
    return newState(state.copyWith(bannedCountries: newList));
  }

  return newState(state.copyWith());
}
