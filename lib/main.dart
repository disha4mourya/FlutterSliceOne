import 'package:flutter/material.dart';
import 'package:flutter_slice_one/login_page.dart';
import 'package:flutter_slice_one/login_page_cooler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    LoginPageCooler.tag: (context) => LoginPageCooler(),
//    HomePage.tag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
//      home: LoginPage(title: 'Flutter Part 1'),
      home: LoginPageCooler(),
    );
  }
}

