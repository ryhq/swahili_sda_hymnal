import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class SongNumber extends StatelessWidget {
  final String songNumber;
  const SongNumber({
    required this.songNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        songNumber.toUpperCase(),
        textAlign: TextAlign.left,
        style: TextStyle(
          color: themeColor,
          fontSize: 14,
          fontWeight: FontWeight.normal
        ),
      ),
    );
  }
}