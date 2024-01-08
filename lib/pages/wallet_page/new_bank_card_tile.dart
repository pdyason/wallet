import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallet/data/models/bank_card.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/state.dart';

class NewBankCardTile extends StatelessWidget {
  const NewBankCardTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: InkWell(
        onTap: () => StoreProvider.of<AppState>(context).dispatch(AddCard(BankCard.sample())),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: const Color.fromARGB(255, 140, 120, 94)),
            color: const Color.fromARGB(255, 232, 223, 214),
          ),
          child: const Center(
            child: Text('Add card', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
