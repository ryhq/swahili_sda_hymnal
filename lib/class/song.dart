import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
class Song {
  final int song_id;
  final String song_name;
  final String key_signature;
  // final List<Map<String, String>> song_lyrics;

  Song({
    required this.song_id,
    required this.song_name,
    required this.key_signature,
    // required this.song_lyrics,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    // final List<Map<String, String>> song_lyrics = List<Map<String, String>>.from(
    //   json['song_lyrics'].map((lyric) => Map<String, String>.from(lyric)),
    // );

    return Song(
      song_id: json['song_id'],
      song_name: json['song_name'],
      key_signature: json['key_signature'],
      // song_lyrics: song_lyrics,
    );
  }
}
class SongLyrics{
  final String verses;
  SongLyrics({
    required this.verses,
    // required this.chorus,
  });
  factory SongLyrics.fromJson(Map<String, dynamic> json){
    return SongLyrics(
      verses: json['verses'],
      // chorus: json['chorus']
    );
  }
}
Future<List<SongLyrics>> getSongLyricsBySongName(String song_name) async{
  final jsonString = await rootBundle.loadString('assets/JSONFiles/songs.json');
  final jsonData = json.decode(jsonString) as List<dynamic>;
  final matchingSong = jsonData.firstWhere(
    (json) => json['song_name'] == song_name,
    orElse: () => null,
  );
  if(matchingSong != null){
    final List<dynamic> songLyrics = matchingSong['song_lyrics'];
    List<SongLyrics> lyrics = songLyrics.map((lyric) => SongLyrics.fromJson(lyric)).toList();
    return lyrics;
  }else return [];
}
