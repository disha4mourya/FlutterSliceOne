import 'package:flutter/material.dart';
import 'package:flutter_slice_one/future_song_list.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: AsyncCallFuture(),
      ),
    );
  }
}