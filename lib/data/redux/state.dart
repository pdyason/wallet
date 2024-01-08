import 'package:wallet/data/models/bank_card.dart';
import 'package:flutter/foundation.dart';

class AppState {
  final List<BankCard> cards;
  final List<String> bannedCountries;

  AppState({required this.cards, required this.bannedCountries});

  factory AppState.initial() {
    return AppState(
      cards: [],
      bannedCountries: [],
    );
  }

  AppState copyWith({
    List<BankCard>? cards,
    List<String>? bannedCountries,
  }) {
    return AppState(
      cards: cards ?? this.cards,
      bannedCountries: bannedCountries ?? this.bannedCountries,
    );
  }

  @override
  String toString() {
    return 'State: cards:${cards.length} banned:${bannedCountries.length}';
  }

  @override
  int get hashCode => Object.hash(cards, bannedCountries);

  @override
  operator ==(other) =>
      other is AppState && listEquals(other.cards, cards) && listEquals(other.bannedCountries, bannedCountries);
}
