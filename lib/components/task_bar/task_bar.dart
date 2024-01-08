import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallet/configs/styles.dart';
import 'package:wallet/data/models/bank_card.dart';
import 'package:wallet/data/redux/actions.dart';
import 'package:wallet/data/redux/state.dart';
import 'package:wallet/configs/constants.dart';
import 'package:wallet/pages/pages.dart';
import 'package:wallet/components/task_bar/styled_icon.dart';

class TaskBar extends StatefulWidget {
  const TaskBar({super.key});

  @override
  State<TaskBar> createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: isOpen ? 250 : 80),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: _buildTaskMenu(),
    );
  }

  Container _buildTaskMenu() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            blurStyle: BlurStyle.normal,
            color: const Color.fromARGB(255, 49, 30, 12).withOpacity(1),
            spreadRadius: 3,
          )
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/task_menu.jpg'),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      ),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Row(
              children: [
                const SizedBox(width: 20),
                const Text(Constants.appName, style: Styles.textStyle),
                const Spacer(),
                IconButton(
                  icon: const StyledIcon(Icons.add_card_outlined),
                  onPressed: _onAddCardPressed,
                  // onPressed: context.dispatch<CompanyController>
                ),
                IconButton(
                  icon: const StyledIcon(Icons.more_vert),
                  onPressed: () => _onMenuPressed(),
                ),
                const SizedBox(width: 10),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 10),
                MenuButton(
                  text: 'Update Banned Countries',
                  iconData: Icons.arrow_right,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BannedPage()),
                  ),
                ),
                MenuButton(
                  text: 'Load Sample Data',
                  iconData: Icons.arrow_right,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Loading Sample Data'),
                      duration: Duration(milliseconds: 1000),
                    ));
                    StoreProvider.of<AppState>(context).dispatch(LoadSampleData());
                  },
                ),
                MenuButton(
                  text: 'Readme',
                  iconData: Icons.arrow_right,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReadmePage()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onAddCardPressed() async {
    StoreProvider.of<AppState>(context).dispatch(AddCard(BankCard.sample()));
  }

  void _onMenuPressed() {
    return setState(() {
      isOpen = !isOpen;
    });
  }
}

class MenuButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final void Function()? onPressed;
  const MenuButton({super.key, required this.iconData, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            StyledIcon(iconData),
            const SizedBox(width: 10),
            Text(text, style: Styles.textStyle.copyWith(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
