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

class AllSongs extends StatefulWidget {
  final int from;
  final int to;
  const AllSongs({super.key, required this.from, required this.to});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {

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
                  itemCount: searching ? searchSong(song_name).length : allSongs.length,
                  itemBuilder: (context, index) {
                    final songs = searching ?  searchSong(song_name)[index] : allSongs[index];
                    return Card(
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(21)),
                      ),
                      child: ListTile(
                        leading: SongNumber(songNumber: "${songs['song_id'].toString()}."),
                        title: SongTitle(songTitle: songs['song_name'].toString()),
                        trailing: IconButton(
                          icon: Icon(
                            Provider.of<LikedSongs>(context).isSongLiked(songs['song_id'])
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Provider.of<LikedSongs>(context).isSongLiked(songs['song_id']) ? favourateColor : themeColor,
                          ),
                          onPressed: () {
                            Provider.of<LikedSongs>(context, listen: false).toggleLike(songs['song_id']);
                          },
                        ),
              
                        onTap: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => ViewSong(song_number: songs['song_id']),
                            )
                          );
                        },
                      ),
                    );
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
      filterSongs(capturedJSONData, widget.from, widget.to);
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

  List<dynamic> filterSongs(List<dynamic> hymn, int from, int to) {
    // Initializing hymnal
    hymnal = hymn.where((song){
      int song_id = song['song_id'] as int;
      return song_id >= from && song_id <= to;
    }).toList();
    allSongs = hymnal;
    return hymn.where((song){
      int song_id = song['song_id'] as int;
      return song_id >= from && song_id <= to;
    }).toList();
  }
}
