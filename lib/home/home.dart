import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swahili_sda_hymnal/allSongs/allSongs.dart';
import 'package:swahili_sda_hymnal/categories/categories.dart';
import 'package:swahili_sda_hymnal/favourates/favourates.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;
  final List<Widget> _appPages = [
    AllSongs(from: 1, to: 220,),
    FavourateSongs(),
    Categories()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _appPages[_currentPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: (value) {
            setState(() {
              _currentPageIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.heart_fill,
              ),
              label: 'Favourates'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.music_note,
              ),
              label: 'Categories'
            ),
          ],
        ),
      )
    );
  }
}
