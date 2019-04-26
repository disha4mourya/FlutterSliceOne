import 'package:flutter/material.dart';
import 'package:flutter_slice_one/future_song_list.dart';
import 'package:flutter_slice_one/home_page_details.dart';
import 'package:flutter_slice_one/login_page_cooler.dart';
import 'package:flutter_slice_one/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    SplashScreen.tag: (context) => SplashScreen(),
    LoginPageCooler.tag: (context) => LoginPageCooler(),
    AsyncCallFuture.tag: (context) => AsyncCallFuture(),
    HomePageDetails.tag: (context) => HomePageDetails(),
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
