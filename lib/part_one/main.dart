import 'package:flutter/material.dart';
import 'package:flutter_slice_one/bloc_arch/view/songs_list_using_bloc.dart';
import 'package:flutter_slice_one/part_one/login.dart';
import 'package:flutter_slice_one/part_one/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    SplashScreen.tag: (context) => SplashScreen(),
    LoginPageCooler.tag: (context) => LoginPageCooler(),
    Songs.tag: (context) => Songs()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white))),
//      home: LoginPage(title: 'Flutter Part 1'),
      initialRoute: SplashScreen.tag,
      routes: routes,
    );
  }
}
