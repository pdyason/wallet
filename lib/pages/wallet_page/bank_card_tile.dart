import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: const Color.fromARGB(255, 140, 120, 94)),
          color: const Color.fromARGB(255, 232, 223, 214),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.credit_card),
                const SizedBox(width: 10),
                Text(card.type),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.numbers),
                const SizedBox(width: 10),
                Text(card.number),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.abc),
                const SizedBox(width: 10),
                Text(card.ccv),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.circle_outlined),
                const SizedBox(width: 10),
                Text(card.country),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BankCardTileD extends StatelessWidget {
  const BankCardTileD(this.card, {super.key});
  final BankCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: const Color.fromARGB(255, 140, 120, 94)),
        color: const Color.fromARGB(255, 232, 223, 214),
      ),
      // child: Row(
      //   children: [
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [Icon(Icons.credit_card), Icon(Icons.numbers)],
      //     ),
      //     SizedBox(width: 10),
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [Text(card.type), Text(card.number)],
      //     ),
      //   ],
      // ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.credit_card),
              const SizedBox(width: 10),
              Text(card.type),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.numbers),
              const SizedBox(width: 10),
              Text(card.number),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.abc),
              const SizedBox(width: 10),
              Text(card.ccv),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.circle_outlined),
              const SizedBox(width: 10),
              Text(card.country),
            ],
          ),
        ],
      ),
    );
  }
}
