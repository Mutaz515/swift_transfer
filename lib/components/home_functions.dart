import 'package:flutter/material.dart';
import 'package:swift_transfer/components/icon_container.dart';
import 'package:swift_transfer/screens/cards_screen.dart';
import 'package:swift_transfer/screens/more_screen.dart';
import 'package:swift_transfer/screens/topup_screen.dart';
import 'package:swift_transfer/screens/send_screen.dart';

class HomeFunctions extends StatelessWidget {
  const HomeFunctions({super.key});

  void _onTapSend(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const SendScreen(),
      ),
    );
  }

  void _onTapReceive(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const TopUpScreen(),
      ),
    );
  }

  void _onTapAddCard(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const CardsScreen(),
      ),
    );
  }

  void _onTapMore(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const MoreScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconContainer(
          icon: Icons.arrow_outward_rounded,
          text: "Send",
          onTap: () {
            _onTapSend(context);
          },
        ),
        IconContainer(
          icon: Icons.add,
          text: "Top Up",
          onTap: () {
            _onTapReceive(context);
          },
        ),
        IconContainer(
          icon: Icons.credit_card,
          text: "Add Card",
          onTap: () {
            _onTapAddCard(context);
          },
        ),
        IconContainer(
          icon: Icons.more_horiz_rounded,
          text: "More",
          onTap: () {
            _onTapMore(context);
          },
        ),
      ],
    );
  }
}
