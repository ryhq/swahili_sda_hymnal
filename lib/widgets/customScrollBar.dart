import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class CustomScrollBar extends StatelessWidget {
  final Widget child;
  final ScrollController scrollController;
  const CustomScrollBar({super.key, required this.child, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbColor: themeColor,
      radius: Radius.circular(7),
      thickness: 8,
      fadeDuration: Duration(milliseconds: 500),
      controller: scrollController,
      child: child
    );
  }
}
