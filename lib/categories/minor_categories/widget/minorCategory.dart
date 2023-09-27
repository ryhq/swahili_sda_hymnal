import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/categories/minor_categories/view_category_songs/view_category_songs.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class MinorCategory extends StatelessWidget {
  final int category_id;
  final String category_name;
  final int from;
  final int to;
  const MinorCategory({
    super.key, required this.category_name, required this.from, required this.to, required this.category_id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(21)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => ViewCategorySongs(title: category_name,from: from, to: to)
              )
            );
          },
          leading: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  category_id.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            category_name,
            style: TextStyle(
              color: themeColor,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(
            "$from - $to",
            style: TextStyle(
              color: themeColor
            ),
          ),
          trailing: Icon(
            CupertinoIcons.forward,
            color: themeColor,
          ),
        ),
      ),
    );
  }
}
