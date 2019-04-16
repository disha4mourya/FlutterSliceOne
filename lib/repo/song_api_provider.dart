import 'dart:async';
import 'dart:convert';
import 'package:flutter_slice_one/models/songs_model.dart';
import 'package:http/http.dart' ;

class SongApiProvider{

  Client client=Client();
  final baseUrl="https://itunes.apple.com/search?term=Michael+jackson";


  Future<ResultModel> fetchSongsList() async{
    final result= await client.get(baseUrl);
    if(result.statusCode==200){
      return ResultModel.fromJson(json.decode(result.body));
    }else{
      throw Exception("Unable to retrive list");
    }
  }
}