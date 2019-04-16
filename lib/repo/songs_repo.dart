import 'dart:async';
import 'package:flutter_slice_one/models/songs_model.dart';
import 'package:flutter_slice_one/repo/song_api_provider.dart';

class SongsRepo {
  final songsApiProvider = SongApiProvider();

  Future<ResultModel> fetchAllSongs() => songsApiProvider.fetchSongsList();
}
