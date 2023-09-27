import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class Category_name extends StatelessWidget {
  final String CategoryName;
  const Category_name({
    required this.CategoryName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        CategoryName.toUpperCase(),
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