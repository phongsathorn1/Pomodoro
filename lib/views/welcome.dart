import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Welcome to Pomodoro app",
              style: TextStyle(fontSize: 20),
            ),
            RaisedButton(
              child: Text("Login"),
              onPressed: () => {Navigator.pushNamed(context, '/login')},
            ),
            RaisedButton(
              child: Text("Register"),
              onPressed: () => {Navigator.pushNamed(context, '/register')},
            ),
            FlatButton(
              child: Text("Forgot password"),
              onPressed: () => {Navigator.pushNamed(context, '/forgot')},
            )
          ],
        ),
      ),
    ));
  }
}
