import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swahili_sda_hymnal/constants/colors.dart';
import 'package:swahili_sda_hymnal/favourates/class/likedSongs.dart';
import 'package:swahili_sda_hymnal/viewSong.dart/viewSong.dart';
import 'package:swahili_sda_hymnal/widgets/customScrollBar.dart';
import 'package:swahili_sda_hymnal/widgets/headingOne.dart';
import 'package:swahili_sda_hymnal/widgets/searchSong.dart';
import 'package:swahili_sda_hymnal/widgets/songNumber.dart';
import 'package:swahili_sda_hymnal/widgets/songTitle.dart';

class FavourateSongs extends StatefulWidget {
  const FavourateSongs({super.key,});

  @override
  State<FavourateSongs> createState() => _FavourateSongsState();
}

class _FavourateSongsState extends State<FavourateSongs> {

  @override
  void initState() {
    super.initState();
    loadAllSongs();
  }

  bool searching = false;
  String song_name = "";
  bool isFavourate = false;
  ScrollController scroll = ScrollController();

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
                setState(() {
                  if(query.isNotEmpty){
                    searching = true;
                    song_name = query;
                  }else{
                    searching = false;
                    song_name = "";
                  }
                });
              }, 
            ),
            allSongs.isEmpty ?
            Center(
              child: CircularProgressIndicator(color: themeColor),
            ):
            Expanded(
              child: CustomScrollBar(
                scrollController: scroll,
                child: ListView.builder(
                  controller: scroll,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: searching
                  ? searchSong(song_name).length
                  : Provider.of<LikedSongs>(context).likedSongIds.length,
              
                  itemBuilder: (context, index) {
                    final songId = searching
                        ? searchSong(song_name)[index]['song_id']
                        : Provider.of<LikedSongs>(context).likedSongIds[index];
                    final song = allSongs.firstWhere(
                      (element) => element['song_id'] == songId,
                      orElse: () => null,
                    );
              
                    if (song != null) {
                      return Card(
                        elevation: 3,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(21)),
                        ),
                        child: ListTile(
                          leading: SongNumber(songNumber: song['song_id'].toString()),
                          title: SongTitle(songTitle: song['song_name'].toString()),
                          trailing: IconButton(
                            icon: Icon(
                              Provider.of<LikedSongs>(context).isSongLiked(song['song_id'])
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Provider.of<LikedSongs>(context).isSongLiked(song['song_id']) ? favourateColor : themeColor,
                            ),
                            onPressed: () {
                              Provider.of<LikedSongs>(context, listen: false).toggleLike(song['song_id']);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewSong(song_number: song['song_id']),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      // Handle the case where the liked song is not found (e.g., if it's removed from the database).
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  List<dynamic> allSongs = [];
  List<dynamic> hymnal = [];

  Future<void> loadAllSongs() async{
    final String theFileWithJSONData = await rootBundle.loadString('assets/JSONFiles/songs.json');
    final capturedJSONData = await json.decode(theFileWithJSONData);
    setState(() {
      allSongs = capturedJSONData;
    });
  }

  List<dynamic> searchSong(String query) {
    return allSongs.where(
      (element) => element['song_name']
      .toString().toLowerCase()
      .contains(
        query.toLowerCase()
        ) || element['song_id']
      .toString().toLowerCase()
      .contains(
        query.toLowerCase())
      ).toList();
  }
}
