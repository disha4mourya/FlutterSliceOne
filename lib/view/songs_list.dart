import 'package:flutter/material.dart';
import 'package:flutter_slice_one/bloc/songs_bloc.dart';
import 'package:flutter_slice_one/models/songs_model.dart';

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
      body: StreamBuilder(
          stream: bloc.allSongs,
          builder: (context, AsyncSnapshot<ResultModel> snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

Widget buildList(AsyncSnapshot<ResultModel> snapshot) {
  return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: new EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              new Text(snapshot.data.results[index].track_name),
              new Image.network(snapshot.data.results[index].artworkUrl_100,
                  fit: BoxFit.fill)
            ],
          ),
        );
        /*return GridTile(
            child: InkResponse(
          enableFeedback: true,
          child: Text(snapshot.data.results[index].track_name),
        ));*/
      });
}
