import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikedSongs with ChangeNotifier {
  List<int> _likedSongIds = [];
  late SharedPreferences _prefs;

  LikedSongs() {
    _loadLikedSongIds();
  }

  List<int> get likedSongIds => _likedSongIds;

  Future<void> _loadLikedSongIds() async {
    _prefs = await SharedPreferences.getInstance();
    final likedSongIds = _prefs.getStringList('likedSongIds');
    if (likedSongIds != null) {
      _likedSongIds = likedSongIds.map((id) => int.parse(id)).toList();
      notifyListeners();
    }
  }

  bool isSongLiked(int songId) {
    return _likedSongIds.contains(songId);
  }

  Future<void> toggleLike(int songId) async {
    if (_likedSongIds.contains(songId)) {
      _likedSongIds.remove(songId);
    } else {
      _likedSongIds.add(songId);
    }
    await _prefs.setStringList(
        'likedSongIds', _likedSongIds.map((id) => id.toString()).toList());
    notifyListeners();
  }
}
