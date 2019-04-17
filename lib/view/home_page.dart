import 'package:flutter/material.dart';
import 'package:flutter_slice_one/view/songs_list.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SongsList(),
      ),
    );
  }
}