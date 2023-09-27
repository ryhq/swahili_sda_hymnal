import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swahili_sda_hymnal/categories/minor_categories/widget/minorCategory.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';
import 'package:swahili_sda_hymnal/widgets/customScrollBar.dart';
import 'package:swahili_sda_hymnal/widgets/headingOne.dart';

class MinorCategories extends StatefulWidget {
  final int category_id;
  final String title;
  const MinorCategories({super.key, required this.title, required this.category_id});

  @override
  State<MinorCategories> createState() => _MinorCategoriesState();
}

class _MinorCategoriesState extends State<MinorCategories> {
  ScrollController scroll = ScrollController();
  @override
  void initState() {
    super.initState();
    loadMinorCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: HeadingOne(headingOne: widget.title),
        centerTitle: true,
        elevation: 0,
        leading: BackButton(
          color: themeColor,
        ),
      ),
      body: 
      minorCategories.isEmpty ?
      Center(
        child: CircularProgressIndicator(
          color: themeColor,
        ),
      ):
      CustomScrollBar(
        scrollController: scroll,
        child: ListView.builder(
          controller: scroll,
          shrinkWrap: true,
          itemCount: minorCategories.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final category = minorCategories[index];
            return MinorCategory(
              category_name: category['category_name'], 
              from: category['from'], 
              to: category['to'], 
              category_id: category['category_id']
            );
          },
        ),
      ),
    );
  }

  List<dynamic> minorCategories = [];
  Future<void> loadMinorCategories() async{
    final String theFileWithJSONData = await rootBundle.loadString('assets/JSONFiles/categories.json');
    final capturedJSONData = await json.decode(theFileWithJSONData);
    setState(() {
      minorCategories = capturedJSONData[widget.category_id-1]['category_contents'];
    });
  }
}
