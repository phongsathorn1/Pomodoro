import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodoro/models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ProfileSetup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileSetupScreen();
  }
}

class ProfileSetupScreen extends State<ProfileSetup> {
  final _formKey = GlobalKey<FormState>();
  FirebaseUser user;
  User test = User();
  String fname, lname, uemail;
  final firstnameuser = TextEditingController();
  final lastnameuser = TextEditingController(text: User.lastname);
  final emailuser = TextEditingController(text: User.email);

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Setup"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 30, 0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Firstname",
                hintText: "Firstname",
                icon:
                    Icon(Icons.account_box, size: 40, color: Color(0xFF4e69a2)),
              ),
              controller: firstnameuser,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Firstname Is Empty";
                }
              },
              onSaved: (value) {
                this.fname = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Lastname",
                hintText: "Lastname",
                icon:
                    Icon(Icons.account_box, size: 40, color: Color(0xFF4e69a2)),
              ),
              controller: lastnameuser,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Lastname Is Empty";
                }
              },
              onSaved: (value) {
                this.lname = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Email",
                icon:
                    Icon(Icons.account_box, size: 40, color: Color(0xFF4e69a2)),
              ),
              controller: emailuser,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return "Email Is Empty";
                }
              },
              onSaved: (value) {
                this.uemail = value;
              },
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Update Your Profile"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    User.firstname = this.fname;
                    User.lastname = this.lname;
                    User.email = this.uemail;
                    updateuserprofile(User.userid);
                    this._showSuccessDialog();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Success!"),
          content: new Text("Your Profile Have Update Now"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Back"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> updateuserprofile(String uid) {
    DocumentReference userReference =
        Firestore.instance.collection('users').document(uid);
    return Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot table = await tx.get(userReference);
      if (table.exists)
        await tx.update(table.reference, {
          'firstname': this.fname,
          'surname': this.lname,
          'email': this.uemail
        });
    }).then((result) {
      return true;
    }).catchError((error) {
      print('Error: $error');
      return false;
    });
  }

  Future getUser() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
      // Navigator.pushNamed(context, '/welcome');
    } else {
      DocumentSnapshot ds =
          await Firestore.instance.collection('users').document(user.uid).get();

      setState(() {
        this.user = user;
        this.firstnameuser.text = ds.data['firstname'];
        this.lastnameuser.text = ds.data['surname'];
        this.emailuser.text = ds.data['email'];
        // this.test = User(
        //     firstname: ds.data['firstname'],
        //     lastname: ds.data['surname'],
        //     email: ds.data['email']);
      });
    }
  }
}
