import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:provider/provider.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';
import 'package:swahili_sda_hymnal/favourates/class/likedSongs.dart';
import 'package:swahili_sda_hymnal/viewSong.dart/widgets/SongAppBarTitle.dart';
import 'package:swahili_sda_hymnal/viewSong.dart/widgets/VerseNumber.dart';
import 'package:swahili_sda_hymnal/viewSong.dart/widgets/chorus.dart';
import 'package:swahili_sda_hymnal/viewSong.dart/widgets/verse.dart';
import 'package:swahili_sda_hymnal/widgets/headingOne.dart';

class ViewSong extends StatefulWidget {
  final int song_number;
  const ViewSong({super.key, required this.song_number,});

  @override
  State<ViewSong> createState() => _ViewSongState();
}

class _ViewSongState extends State<ViewSong> {
  @override
  void initState() {
    super.initState();
    loadSong();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: themeColor,
          ),
          backgroundColor: Colors.white,
          title: SongAppBarTitle(widget: widget),
          centerTitle: true,
          elevation: 0,
          actions: [
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            HeadingOne(headingOne: song_name),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 14.0),
              child: key_signature.isEmpty || time_signature.isEmpty ? null :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Key: $key_signature",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                  Text(
                    "Time: $time_signature",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: song_verses.length,
              itemBuilder: (context, index) {
                final verse = song_verses[index];
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:  7.0),
                        child: VerseNumber(verseNumber: index),
                      ),
                      Expanded(child: Verse(verse: verse['verse'])),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: song_chorus.isEmpty ? null : 
              Chorus(song_chorus: song_chorus),
            ),
            refrain.isEmpty? Container():
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: song_chorus.isEmpty ? null : 
              Chorus(song_chorus: refrain),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          
          onPressed: () {
            Provider.of<LikedSongs>(context, listen: false).toggleLike(widget.song_number);
          },
          child: Consumer<LikedSongs>(
            builder: (context, likedSongs, child) {
              final isLiked = likedSongs.isSongLiked(widget.song_number);
              return Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? favourateColor : themeColor,
              );
            },
          ),
        ),
      )
    );
  }
  List<dynamic> song_lyrics = [];
  List<dynamic> song_verses = [];
  String song_name = "";
  String song_chorus = "";
  String refrain = "";
  String key_signature = "";
  String time_signature = "";
  Future<void> loadSong() async{
    final String theFileWithJSONData = await rootBundle.rootBundle.loadString('assets/JSONFiles/songs.json');
    final capturedJSONData = await json.decode(theFileWithJSONData);
    setState(() {
      song_name = capturedJSONData[widget.song_number-1]['song_name'];
      song_lyrics = capturedJSONData[widget.song_number-1]['song_lyrics'];
      song_verses = song_lyrics[0]['verses'];
      song_chorus = song_lyrics[1]['chorus'];
      if ( song_lyrics.length > 2) {
        refrain = song_lyrics[2]['chorus'];
      }
      key_signature = capturedJSONData[widget.song_number-1]['key_signature'];
      time_signature = capturedJSONData[widget.song_number-1]['time_signature'];
    });
  } 
  List<dynamic> searchSong(String song_name) {
    return song_lyrics
      .where((element) => element['song_name']
        .toString()
        .toLowerCase()
        .contains(song_name.toLowerCase())).toList();
  }
}


