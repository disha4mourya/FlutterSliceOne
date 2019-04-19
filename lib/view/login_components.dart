import 'package:flutter/material.dart';

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

Widget button(BuildContext buildContext, {Function() onTap}) {
  return Container(
    margin: new EdgeInsets.all(20.0),
    child: Column(
      children: <Widget>[
        new RaisedButton(
            child: const Text("Login"),
            elevation: 4.0,
            onPressed: () => onTap())
           // onPressed: () => showMessage())
      ],
    ),
  );
}