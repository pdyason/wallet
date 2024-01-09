import 'package:wallet/data/models/bank_card.dart';
import 'package:flutter/foundation.dart';

class AppState {
  final List<BankCard> cards;
  final List<BankCard> newCards;
  final List<String> bannedCountries;

  AppState({required this.cards, required this.newCards, required this.bannedCountries});

  factory AppState.initial() {
    return AppState(cards: [], newCards: [], bannedCountries: []);
  }

  AppState copyWith({
    List<BankCard>? cards,
    List<BankCard>? newCards,
    List<String>? bannedCountries,
  }) {
    return AppState(
      cards: cards ?? this.cards,
      newCards: newCards ?? this.newCards,
      bannedCountries: bannedCountries ?? this.bannedCountries,
    );
  }

  @override
  String toString() => 'State: cards:${cards.length} new:${newCards.length} banned:${bannedCountries.length}';

  @override
  int get hashCode => Object.hash(cards, newCards, bannedCountries);

  @override
  operator ==(other) =>
      other is AppState &&
      listEquals(other.cards, cards) &&
      listEquals(other.newCards, newCards) &&
      listEquals(other.bannedCountries, bannedCountries);
}
