import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  FirebaseUser user;
  User test = User();
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text("This is home page"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/avatar.png'),
                                  fit: BoxFit.fill
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "${this.test.firstname} ${this.test.lastname}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ],
                      ))
                ],
                // child: Text("Drawer Header")
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              )),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Add Profile Picture"),
            onTap: () {
              Navigator.pushNamed(context, '/addProfilePic');
            },
          ),
          ListTile(
            leading: Icon(Icons.new_releases),
            title: Text("Features"),
            onTap: () {
              Navigator.pushNamed(context, '/features');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              this.logout(context);
            },
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Place")),
        ],
        onTap: (index) {
          setState(() {
            this._navIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Pomodoro Clock",
        child: Icon(Icons.alarm),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future checkAuth() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
      // Navigator.pushNamed(context, '/welcome');
    } else {
      DocumentSnapshot ds =
          await Firestore.instance.collection('users').document(user.uid).get();

      setState(() {
        this.user = user;
        this.test =
            User(firstname: ds.data['firstname'], lastname: ds.data['surname']);
      });
    }
  }

  Future logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
  }
}
