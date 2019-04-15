import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>{
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                labelText: "Email"
              ),
            ),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                labelText: "Password"
              ),
            )
          ]),
        )
      ),
    );
  }

}