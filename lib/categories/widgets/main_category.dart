import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/categories/minor_categories/minor_categories.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';

class MainCategory extends StatelessWidget {
  final int category_id;
  final String category_name;
  final String from;
  final String to;
  const MainCategory({
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
                builder: (context) => MinorCategories(category_id: category_id,title: category_name)
              )
            );
          },
          leading: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "${category_id.toString()}.",
                  style: TextStyle(
                    fontSize: 18,
                    color: themeColor,
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
              fontWeight: FontWeight.normal
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
