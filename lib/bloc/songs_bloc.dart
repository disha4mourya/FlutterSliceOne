import 'package:flutter_slice_one/models/songs_model.dart';
import 'package:flutter_slice_one/repo/songs_repo.dart';
import 'package:rxdart/rxdart.dart';

class SongsBloc{
  final repo=SongsRepo();
  final songsFetcher= PublishSubject<ResultModel>();

  Observable<ResultModel> get allSongs => songsFetcher.stream;

  fetchAllSongs() async{
    ResultModel resultModel=await repo.fetchAllSongs();
    songsFetcher.sink.add(resultModel);
  }

  dispose(){
    songsFetcher.close();
  }
}

final bloc=SongsBloc();