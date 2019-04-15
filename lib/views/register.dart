import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Center(
              child: Column(
                children: <Widget>[
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
                      if (value != _passwordConfirm.text){
                        return "Password confirmation and Password field are not same.";
                      }
                    },
                  ),
                  TextFormField(
                    controller: _passwordConfirm,
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password Confirm"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please fill password confirm";
                      }
                      if (value != _password.text){
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
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<bool> _register() async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: _email.text, 
      password: _password.text
    );
    
    if(user != null){
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = "Test Name";

      await user.updateProfile(info);
      await user.sendEmailVerification();
      return true;
    }else{
      return false;
    }
  }
}
