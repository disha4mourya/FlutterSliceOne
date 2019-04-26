import 'dart:async';

import 'package:countdown/countdown.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'future_song_list.dart';
import 'login_page_cooler.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/';

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  StreamSubscription sub;

  _SplashState(){
    checkLoginState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 200,
        ),
      ),
    );
  }

 /* @override
  void initState() {
    super.initState();
    checkLoginState();
  }*/

  void checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = (prefs.getBool('isLoggedIn') ?? false);

    CountDown cd = CountDown(Duration(seconds: 3));
    sub = cd.stream.listen(null);
    sub.onDone(() {
      if (isLoggedIn) {
        Route route =
            MaterialPageRoute(builder: (context) => AsyncCallFuture());
        Navigator.pushReplacement(context, route);
      } else {
        // Navigator.of(context).pushNamed(LoginPageCooler.tag);
        Route route =
            MaterialPageRoute(builder: (context) => LoginPageCooler());
        Navigator.pushReplacement(context, route);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    sub.cancel();
  }
}
