import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class SongTitle extends StatelessWidget {
  final String songTitle;
  const SongTitle({
    required this.songTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        songTitle.toUpperCase(),
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