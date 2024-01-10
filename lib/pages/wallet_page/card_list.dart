import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallet/app/app.dart';
import 'package:wallet/app/styles.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/state.dart';
import 'package:wallet/pages/wallet_page/bank_card_tile.dart';
import 'package:wallet/pages/wallet_page/new_bank_card_tile.dart';

class CardList extends StatefulWidget {
  const CardList({
    super.key,
  });

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final ScrollController _scrollController = ScrollController();
  int numberOfCards = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      StoreProvider.of<AppState>(context).onChange.listen((state) {
        if (state.cards.length != numberOfCards) {
          numberOfCards = state.cards.length;
          _scrollDown();
        }
      });
    });
  }

  void _scrollDown() {
    if (_scrollController.positions.isNotEmpty) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Styles.listBackgroundColor,
          ),
          child: ListView(
            reverse: true,
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            children: [
              if (state.cards.isEmpty) const NewBankCardTile(),
              ...state.cards
                  .map((card) => Dismissible(
                      key: Key(card.toString()),
                      onDismissed: (direction) {
                        StoreProvider.of<AppState>(context).dispatch(RemoveCard(card));
                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Removed ${card.number}'),
                          action: SnackBarAction(
                            label: 'Undo',
                            textColor: Styles.cardBackgroundColor,
                            onPressed: () {
                              StoreProvider.of<AppState>(App.navKey.currentContext!)
                                  .dispatch(SetAppState(state.copyWith()));
                            },
                          ),
                          duration: const Duration(milliseconds: 2000),
                        ));
                      },
                      child: BankCardTile(
                        card: card,
                        isNewlyAdded: state.newCards.contains(card),
                      )))
                  .toList()
                  .reversed,
            ],
          ),
        );
      },
    );
  }
}
