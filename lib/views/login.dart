import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>{
  final _formKey = GlobalKey<FormState>();

  FirebaseUser user;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isLoading = false;

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
              validator: (value) {
                if(value.isEmpty){
                  return "Please fill email";
                }
              },
            ),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                labelText: "Password"
              ),
              obscureText: true,
              autocorrect: false,
              validator: (value) {
                if(value.isEmpty){
                  return "Plesae fill password";
                }
              },
            ),
            this._loadingIndicator(),
            RaisedButton(
              child: Text("Login"),
              onPressed: () async {
                if(_formKey.currentState.validate()){
                  setState(() {
                    this._isLoading = true;
                  });
                  
                  try {
                    this.user = await _auth.signInWithEmailAndPassword(
                      email: _email.text.trim(),
                      password: _password.text.trim()
                    );

                    setState(() {
                      this._isLoading = false;
                    });
                    
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                  }
                  catch (e) {
                    setState(() {
                      this._isLoading = false;
                    });

                    showDialog(
                      context: context,
                      builder: (BuildContext context){
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
                      }
                    );
                  }
                }
              },
            )
          ]),
        )
      ),
    );
  }

}