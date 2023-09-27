import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class VerseNumber extends StatelessWidget {
  final int verseNumber;
  const VerseNumber({
    super.key,
    required this.verseNumber
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "${verseNumber+1}.",
      style: TextStyle(
        color: themeColor,
        fontSize: 16,
        fontWeight: FontWeight.bold
      ),
    );
  }
}