import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallet/app/styles.dart';
import 'package:wallet/app/utils.dart';
import 'package:wallet/data/models/bank_card.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/state.dart';

class BankCardTile extends StatelessWidget {
  const BankCardTile(this.card, {super.key});
  final BankCard card;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(card.toString()),
      onDismissed: (direction) {
        StoreProvider.of<AppState>(context).dispatch(RemoveCard(card));
        // Then show a snackbar.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Removed $card'),
          duration: const Duration(milliseconds: 1000),
        ));
      },
      child: Container(
        height: Styles.cardHeight,
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Styles.cardBorderColor),
          color: Styles.cardBackgroundColor,
        ),
        child: BankCardTileView(card: card),
      ),
    );
  }
}

class BankCardTileView extends StatelessWidget {
  const BankCardTileView({super.key, required this.card});

  final BankCard card;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top-left corner widget
        Positioned(top: 0, left: 0, child: CardTypeWidget(card: card)),
        // Top-right corner widget
        Positioned(top: 0, right: 0, child: CardAliasWidget(card: card)),
        // Bottom-left corner widget
        Positioned(bottom: 0, left: 0, child: CardCountryWidget(card: card)),
        // Bottom-right corner widget
        Positioned(bottom: 0, right: 0, child: CardCCVWidget(card: card)),
        // Center widget
        Center(
          child: SizedBox(
            width: double.maxFinite,
            child: CardNumberWidget(card: card),
          ),
        ),
      ],
    );
  }
}

class CardTypeWidget extends StatelessWidget {
  const CardTypeWidget({super.key, required this.card});
  final BankCard card;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(Icons.credit_card, size: 30),
        const SizedBox(width: 10),
        Text(card.type, style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}

class CardNumberWidget extends StatelessWidget {
  const CardNumberWidget({super.key, required this.card});
  final BankCard card;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(Utils.formatCardNumber(card.number), style: const TextStyle(fontSize: 25)),
    );
  }
}

class CardAliasWidget extends StatelessWidget {
  const CardAliasWidget({super.key, required this.card});
  final BankCard card;
  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown);
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Row(children: [
            if (state.newCards.contains(card)) Text('New:', style: textStyle),
            const SizedBox(width: 10),
            Text(card.alias, style: textStyle),
          ]);
        });
  }
}

class CardCCVWidget extends StatelessWidget {
  const CardCCVWidget({super.key, required this.card});
  final BankCard card;
  @override
  Widget build(BuildContext context) {
    return Text('CCV  ${card.ccv}');
  }
}

class CardCountryWidget extends StatelessWidget {
  const CardCountryWidget({super.key, required this.card});
  final BankCard card;
  @override
  Widget build(BuildContext context) {
    return Text(card.country);
  }
}
