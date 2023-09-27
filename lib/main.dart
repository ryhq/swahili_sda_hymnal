import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swahili_sda_hymnal/favourates/class/likedSongs.dart';
import 'package:swahili_sda_hymnal/home/home.dart';
void main(List<String> args) {
  runApp(ChangeNotifierProvider(
    create: (context) => LikedSongs(),
    child: const SwahiliSDAHymnal()
    )
  );
}
class SwahiliSDAHymnal extends StatelessWidget {
  const SwahiliSDAHymnal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nyimbo za Kristo',
      theme: ThemeData(
        fontFamily: 'Georgia'
      ),
      debugShowCheckedModeBanner: false,
      home: DelayedHome(),
    );
  }
}
class DelayedHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 1500)),
      builder: (context, snapshot) {
        return Home();
      },
    );
  }
}