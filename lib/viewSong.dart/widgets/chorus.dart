
import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class Chorus extends StatelessWidget {

  final String song_chorus;
  
  const Chorus({
    super.key,
    required this.song_chorus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chorus',
          style: TextStyle(
            color: themeColor,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            song_chorus,
            style: TextStyle(
              color: themeColor,
              fontSize: 18,
              fontWeight: FontWeight.normal
            ),
          ),
        ),
      ],
    );
  }
}