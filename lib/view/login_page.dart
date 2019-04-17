import 'package:flutter/material.dart';
import 'package:flutter_slice_one/view/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  void showMessage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
    Fluttertoast.showToast(
        msg: "Fetching data from server...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (context) => Center(
              child: Column(
                children: <Widget>[inputFields(), button(context)],
                //child: inputFields(),
              ),
            ),
      ),
    );
  }

  Widget inputFields() {
    return Container(
      margin: new EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          new TextFormField(
            decoration: new InputDecoration(hintText: "Email"),
          ),
          new TextFormField(
            decoration: new InputDecoration(hintText: "Password"),
          )
        ],
      ),
    );
  }

  Widget button(BuildContext buildContext) {
    return Container(
      margin: new EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          new RaisedButton(
              child: const Text("Login"),
              color: Theme.of(context).accentColor,
              elevation: 4.0,
              onPressed: () => showMessage())
        ],
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
