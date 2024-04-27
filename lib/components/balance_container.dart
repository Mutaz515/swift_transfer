import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceContainer extends StatefulWidget {
  const BalanceContainer({super.key, required this.balance});

  final num balance;

  @override
  State<BalanceContainer> createState() => _BalanceContainerState();
}

class _BalanceContainerState extends State<BalanceContainer> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return Container(
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(24, 74, 255, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "AED",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                visible
                    ? Text(
                        myFormat.format(widget.balance),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(
                        "**********",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  visible = !visible;
                });
              },
              icon: visible
                  ? const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.white,
                      size: 32,
                    )
                  : const Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
