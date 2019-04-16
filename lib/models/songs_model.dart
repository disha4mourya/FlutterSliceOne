class ResultModel{

  int resultCount;
  List<SongsModel> results=[];

  ResultModel.fromJson(Map<String, dynamic> parsedJson){
    resultCount=parsedJson['resultCount'];
    print("CountIS" +resultCount.toString());
  }

}

class SongsModel{
  String _wrapper_type;
  String _track_name;
}