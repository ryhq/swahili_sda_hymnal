import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class Chorus extends StatelessWidget {
  final String? chorus;
  const Chorus({
    required this.chorus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        chorus!,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: themeColor,
          fontSize: 21,
          fontWeight: FontWeight.normal
        ),
      ),
    );
  }
}