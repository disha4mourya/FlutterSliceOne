class ResultModel {
  int resultCount;
  List<SongsModel> results = [];

  ResultModel.fromJson(Map<String, dynamic> parsedJson) {
    resultCount = parsedJson['resultCount'];
    print("CountIS" + resultCount.toString());

    List<SongsModel> songs = [];

    for (int i = 0; i < parsedJson['results'].length; i++) {
      SongsModel songModel = SongsModel(parsedJson['results'][i]);
      songs.add(songModel);
    }

    results = songs;
  }
}

class SongsModel {
  String _wrapper_type;
  String _track_name;

  SongsModel(result) {
    _wrapper_type = result['wrapperType'];
    _track_name = result['trackName'];
  }

  String get wrapper_type => _wrapper_type;

  String get track_name => _track_name;
}
