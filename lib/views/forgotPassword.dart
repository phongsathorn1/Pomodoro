import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

class ForgotScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotScreenState();
  }
}

class ForgotScreenState extends State<ForgotScreen> {

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();

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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Forgot password"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(children: <Widget>[
            TextFormField(
              controller: _email,
              decoration: InputDecoration(labelText: "Email Address"),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter email address";
                }
              },
            ),
            RaisedButton(
              child: Text("Continue"),
              onPressed: () {
                if (_formKey.currentState.validate()){
                  this.resetPassword(context);
                }
              },
            ),
            this._loadingIndicator()
          ]),
        ),
      ),
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    setState(() {
      this._isLoading = true;
    });
    try{
      await _auth.sendPasswordResetEmail(email: this._email.text.trim());

      setState(() {
        this._isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Reset Password"),
            content: Text("We send the email for reset your password. Please check your email's inbox."),
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
        }
      );
    }
    catch(error){
      setState(() {
        this._isLoading = false;
      });

      String errorMsg = 'Error!';

      if(error.code == 'ERROR_USER_NOT_FOUND'){
        errorMsg = 'We not found your email in our record.';
      }
      else if(error.code == 'ERROR_INVALID_EMAIL'){
        errorMsg = 'Invalid email address.';
      }

      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(errorMsg,
            style: TextStyle(
              color: Colors.white
            )
          ),
          backgroundColor: Colors.red,
        )
      );

    }
  }
}
