import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swahili_sda_hymnal/class/song.dart';
import 'package:swahili_sda_hymnal/viewSong.dart/viewSong.dart';
import 'package:swahili_sda_hymnal/widgets/headingOne.dart';
import 'package:swahili_sda_hymnal/widgets/searchSong.dart';
import 'package:swahili_sda_hymnal/widgets/songNumber.dart';
import 'package:swahili_sda_hymnal/widgets/songTitle.dart';

class AllSongsV1 extends StatefulWidget {
  const AllSongsV1({super.key});

  @override
  State<AllSongsV1> createState() => _AllSongsV1State();
}

class _AllSongsV1State extends State<AllSongsV1> {
  List<Song> songs = [];

  @override
  void initState() {
    super.initState();
    loadSongs();
  }

  Future<void> loadSongs() async {
    final String jsonString = await rootBundle.loadString('assets/JSONFiles/songs.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    setState(() {
      songs = jsonList.map((json) => Song.fromJson(json)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: HeadingOne(headingOne: "Nyimbo Za Kristo"),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchSong(
              hintText: "Tafuta wimbo kwa jina au namba",
              result: (String query) {
              }, 
            ),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SongNumber(songNumber: songs[index].song_id.toString()),
                  title: SongTitle(songTitle: songs[index].song_name.toString()),
                  trailing: Icon(
                    CupertinoIcons.heart
                  ),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => ViewSong(song_number: songs[index].song_id),
                      )
                    );
                  },
                );
              },
            ),
          ],
        ),
      )
    );
  }
}