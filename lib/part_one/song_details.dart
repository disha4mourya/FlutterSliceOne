import 'package:flutter/material.dart';
import 'package:flutter_slice_one/part_one/screen_arguments.dart';

class HomePageDetails extends StatelessWidget {
  static String tag = '/home-page-details';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    final topArtistImage = Hero(
      tag: args.heroTag,
      child: CircleAvatar(
        radius: 128.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(args.imageURL),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.fromLTRB(0, 24, 0, 12),
      child: Text(
        args.title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 32.0, color: Colors.white),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        args.subTitle,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22.0, color: Colors.white70),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blueAccent[400],
              Colors.blue[600],
              Colors.lightBlue[500],
              Colors.lightBlue[400],
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[topArtistImage, welcome, lorem],
      ),
    );

    return MaterialApp(
        home: Scaffold(
      body: body,
    ));
  }
}
