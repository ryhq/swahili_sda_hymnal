import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class SearchSong extends StatelessWidget {
  final String hintText;
  const SearchSong({
    super.key,
    required this.result,
    required this.hintText,
  });
  final Function(String query) result;

  @override
  Widget build(BuildContext context) {
    String searchData = "";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: searchData,
        onChanged: (value) {
          result(value);
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(21),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: themeColor),
            borderRadius: BorderRadius.circular(21),
          ),
          hintText: hintText,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color:themeColor,
          ),
        ),
      ),
    );
  }
}
