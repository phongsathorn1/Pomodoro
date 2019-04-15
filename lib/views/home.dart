import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: <Widget>[
          RaisedButton(
            child: Text("Login"),
            onPressed: () => {
              Navigator.pushNamed(context, '/login')
            },
          ),
          RaisedButton(
            child: Text("Register"),
            onPressed: () => {
              Navigator.pushNamed(context, '/register')
            },
          )
        ],),
      ),
    );
  }
}