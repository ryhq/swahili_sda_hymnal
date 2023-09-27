import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class Verse extends StatelessWidget {
  final String verse;
  const Verse({
    super.key,
    required this.verse,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      verse,
      style: TextStyle(
        color: themeColor,
        fontSize: 18,
        fontWeight: FontWeight.normal
      ),
    );
  }
}