
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class FavourateButton extends StatefulWidget {
  const FavourateButton({
    super.key,
  });

  @override
  State<FavourateButton> createState() => _FavourateButtonState();
}

class _FavourateButtonState extends State<FavourateButton> {
  bool isFavourate = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isFavourate = !isFavourate;
        });
      }, 
      icon: isFavourate ? Icon(
        CupertinoIcons.heart_fill,
        color: themeColor,
      ):Icon(
        CupertinoIcons.heart,
        color: themeColor,
      ),
    );
  }
}