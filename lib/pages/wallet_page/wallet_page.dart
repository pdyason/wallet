import 'package:flutter/material.dart';
import 'package:wallet/pages/wallet_page/card_list.dart';
import 'package:wallet/components/task_bar/task_bar.dart';
import 'package:wallet/configs/styles.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Styles.listBackgroundColor,
      bottomNavigationBar: TaskBar(),
      body: CardList(),
    );
  }
}
