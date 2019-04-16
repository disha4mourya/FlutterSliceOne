import 'package:flutter/material.dart';
import 'package:flutter_slice_one/bloc/songs_bloc.dart';

class SongsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SongsListState();
  }
}

class SongsListState extends State<SongsList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOngs'),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
