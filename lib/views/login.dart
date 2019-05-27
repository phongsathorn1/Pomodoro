import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodoro/feature/feature.dart';
import 'package:pomodoro/fonts/fonts.dart';
import 'package:pomodoro/insert/homepage.dart';
import 'package:pomodoro/models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  FirebaseUser user;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  Widget _loadingIndicator() {
    if (this._isLoading) {
      return CircularProgressIndicator();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
            child: Text(
          "Reading Guide",
          style: TextStyle(
              fontFamily: GetTextStyle(), fontSize: 30.0, color: Colors.white),
        )),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  icon: Icon(Icons.account_box,
                      size: 40, color: Color(0xFF4e69a2)),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill email";
                  }
                },
              ),
              TextFormField(
                controller: _password,
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  icon: Icon(Icons.lock, size: 40, color: Color(0xFF4e69a2)),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Plesae fill password";
                  }
                },
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      this._isLoading = true;
                    });

                    try {
                      var user = await _auth.signInWithEmailAndPassword(
                          email: _email.text.trim(),
                          password: _password.text.trim());
                      User.lastname = user.displayName.split(' ')[0];
                      User.firstname = user.displayName.split(' ')[1];
                      User.email = user.email;
                      User.userid = user.uid;
                      setState(() {
                        this._isLoading = false;
                      });
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Login"),
                              content: Text("Login Success"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Done"),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => IntroScreen(),
                                      ),
                                    );
                                  },
                                )
                              ],
                            );
                          });
                    } catch (e) {
                      setState(() {
                        this._isLoading = false;
                      });

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Login"),
                              content: Text("Login Falied"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Done"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    }
                  }
                },
              ),
              this._loadingIndicator(),
              Row(
                children: <Widget>[
                  FlatButton(
                    child: Text("Register"),
                    onPressed: () =>
                        {Navigator.pushNamed(context, '/register')},
                  ),
                  FlatButton(
                    child: Text("Forgot password"),
                    onPressed: () => {Navigator.pushNamed(context, '/forgot')},
                  )
                ],
              )
            ]),
          )),
    );
  }
}
