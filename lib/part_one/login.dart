import 'package:flutter/material.dart';
import 'package:flutter_slice_one/bloc_arch/view/songs_list_using_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageCooler extends StatefulWidget {
  static String tag = '/login_page_cooler';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPageCooler> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _validateEmail = false;
  bool _validatePassword = false;

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: FlutterLogo(
            size: 200,),
    );

    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        errorText: _validateEmail ? 'Email Can\'t Be Empty' : null,
      ),
    );

    final password = TextField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        errorText: _validatePassword ? 'Password Can\'t Be Empty' : null,
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          processLogin(context);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              // Retrieve the text the user has typed in using our
              // TextEditingController
              content: Text("Forget Password"),
            );
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 12.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }

  void processLogin(BuildContext context) async {
    var email = emailController.text;
    var pass = passwordController.text;

    setState(() {
      _validateEmail = emailController.text.isEmpty ? true : false;
      _validatePassword = passwordController.text.isEmpty ? true : false;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (email == "test@gmail.com" && pass == "1234") {
      await prefs.setBool('isLoggedIn', true);
      // Navigator.of(context).pushNamed(AsyncCallFuture.tag);
      Route route = MaterialPageRoute(builder: (context) => Songs());
      Navigator.pushReplacement(context, route);
    } else {
      showMessage();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text('Invalid Email and Password'),
    ));
  }

  void showMessage() {
    Fluttertoast.showToast(
        msg: "Invalid Email and Password",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
