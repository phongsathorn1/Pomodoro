import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  FirebaseUser user;

  TextEditingController _name = TextEditingController();
  TextEditingController _surname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirm = TextEditingController();

  Widget _loadingIndicator(){
    if(this._isLoading){
      return CircularProgressIndicator();
    }else{
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Flexible(
                            child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: TextFormField(
                            controller: _name,
                            autocorrect: false,
                            decoration: InputDecoration(labelText: "Name"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please fill name";
                              }
                            },
                          ),
                        )),
                        Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: _surname,
                                  autocorrect: false,
                                  decoration:
                                      InputDecoration(labelText: "Surname"),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Please fill surname";
                                    }
                                  },
                                ))),
                      ]),
                      TextFormField(
                        controller: _email,
                        autocorrect: false,
                        decoration: InputDecoration(labelText: "Email Address"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill email address";
                          }
                        },
                      ),
                      TextFormField(
                        controller: _password,
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Password"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill password";
                          }
                          if (value != _passwordConfirm.text) {
                            return "Password confirmation and Password field are not same.";
                          }
                        },
                      ),
                      TextFormField(
                        controller: _passwordConfirm,
                        autocorrect: false,
                        obscureText: true,
                        decoration:
                            InputDecoration(labelText: "Password Confirm"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill password confirm";
                          }
                          if (value != _password.text) {
                            return "Password confirmation and Password field are not same.";
                          }
                        },
                      ),
                      RaisedButton(
                        child: Text("Register"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            if (await this._register()) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Register"),
                                      content: Text("Register Successful"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Done"),
                                          onPressed: () {
                                            Navigator.of(context).popAndPushNamed('/welcome');
                                            // Navigator.of(context).pop();
                                            // Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            }else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Register"),
                                    content: Text("Register Failed"),
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
                      this._loadingIndicator()
                    ],
                  ),
                ),
              ),
            )));
  }

  Future<bool> _register() async {
    setState(() {
      this._isLoading = true;
    });

    try{
      this.user = await _auth.createUserWithEmailAndPassword(
        email: _email.text, password: _password.text);
    }
    catch(e){
      setState(() {
        this._isLoading = false;
      });
      return false;
    }

    setState(() {
      this._isLoading = false;
    });

    if (this.user != null) {
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = "${this._surname.text} ${this._name.text}";
      await this.user.updateProfile(info);

      Firestore.instance.collection('users').document(user.uid).setData({
        'firstname': this._name.text.trim(),
        'surname': this._surname.text.trim(),
        'uid': user.uid,
        'email': user.email,
        'isEmailVerified': user.isEmailVerified,
        'photoUrl': user.photoUrl,
      });

      await this.user.sendEmailVerification();

      return true;
    } else {
      return false;
    }
  }
}
