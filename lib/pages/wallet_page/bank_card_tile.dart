import 'package:flutter/material.dart';
import 'package:wallet/app/styles.dart';
import 'package:wallet/app/utils.dart';
import 'package:wallet/data/models/bank_card.dart';

class BankCardTile extends StatelessWidget {
  const BankCardTile({super.key, required this.card, required this.isNewlyAdded});
  final BankCard card;
  final bool isNewlyAdded;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Styles.cardHeight,
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Styles.cardBorderColor),
        color: Styles.cardBackgroundColor,
      ),
      child: Stack(
        children: [
          // Top-left corner widget
          Positioned(top: 0, left: 0, child: CardTypeWidget(card: card)),
          // Top-right corner widget
          Positioned(top: 0, right: 0, child: CardLabelWidget(card: card, isNewlyAdded: isNewlyAdded)),
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
      ),
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

class CardLabelWidget extends StatelessWidget {
  const CardLabelWidget({super.key, required this.card, required this.isNewlyAdded});
  final BankCard card;
  final bool isNewlyAdded;
  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown);
    return Row(children: [
      if (isNewlyAdded) Text('*', style: textStyle),
      const SizedBox(width: 10),
      Text(card.label, style: textStyle),
    ]);
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
