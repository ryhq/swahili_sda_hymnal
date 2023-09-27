import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';
import 'package:swahili_sda_hymnal/viewSong.dart/viewSong.dart';

class SongAppBarTitle extends StatelessWidget {
  const SongAppBarTitle({
    super.key,
    required this.widget,
  });

  final ViewSong widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.song_number.toString()}',
      style: TextStyle(
        color: themeColor,
        fontSize: 21,
        fontWeight: FontWeight.bold
      ),
    );
  }
}