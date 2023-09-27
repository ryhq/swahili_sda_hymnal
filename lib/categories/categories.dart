import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swahili_sda_hymnal/categories/widgets/main_category.dart';
import 'package:swahili_sda_hymnal/widgets/customScrollBar.dart';
import 'package:swahili_sda_hymnal/widgets/headingOne.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  ScrollController scroll = ScrollController();
  @override
  void initState() {
    super.initState();
    loadAllCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: HeadingOne(headingOne: "Song's Categories"),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: CustomScrollBar(
        scrollController: scroll,
        child: ListView.builder(
          controller: scroll,
          shrinkWrap: true,
          itemCount: allCategories.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final category = allCategories[index];
            return Column(
              children: [
                MainCategory(
                  category_id: category['category_id'],
                  category_name: category['category_name'], 
                  from: category['from'].toString(), 
                  to: category['to'].toString()
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<dynamic> allCategories = [];
  List<dynamic> categoryContents = [];

  Future<void> loadAllCategories() async{
    final String theFileWithJSONData = await rootBundle.loadString('assets/JSONFiles/categories.json');
    final capturedJSONData = await json.decode(theFileWithJSONData);
    setState(() {
      allCategories = capturedJSONData;
      categoryContents = capturedJSONData;
    });
  }
}
