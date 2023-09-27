import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class Range extends StatelessWidget {
  final int from;
  final int to;
  const Range({
    super.key, required this.from, required this.to,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Kwanzia: $from",
          style: TextStyle(
            color: themeColor,
            fontSize: 14,
            fontWeight: FontWeight.normal
          ),
        ),
        Text(
          "Hadi: $to",
          style: TextStyle(
            color: themeColor,
            fontSize: 14,
            fontWeight: FontWeight.normal
          ),
        ),
      ],
    );
  }
}