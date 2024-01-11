import 'package:flutter/material.dart';
import 'package:wallet/app/styles.dart';
import 'package:wallet/pages/new_card_page/new_card_page.dart';

class NewBankCardTile extends StatefulWidget {
  const NewBankCardTile({super.key});

  @override
  State<NewBankCardTile> createState() => _NewBankCardTileState();
}

class _NewBankCardTileState extends State<NewBankCardTile> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // // Trigger the fade-in effect after a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: opacity,
      child: Container(
        height: Styles.cardHeight,
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NewCardPage())),
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
      ),
    );
  }
}
