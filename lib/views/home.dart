import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../models/user.dart';
import 'package:pomodoro/views/book_review_screen.dart';
import 'package:pomodoro/views/location_review_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

TabController controller;

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  FirebaseUser user;
  User test = User();
  int _navIndex = 0;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    checkAuth();
    _isLoading = true;
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _navIndex,
      child: Scaffold(
        appBar: AppBar(),
        body: TabBarView(
          children: <Widget>[
            BookReviewScreen(),
            LocationReviewScreen(),
          ],
          controller: controller,
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
                                      fit: BoxFit.fill),
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
        bottomNavigationBar: Container(
          child: TabBar(
            onTap: (index) {
              setState(() {
                _navIndex = index;
              });
            },
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.home)),
            ],
            controller: controller,
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   tooltip: "Pomodoro Clock",
        //   child: Icon(Icons.alarm),
        //   onPressed: () {},
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Future checkAuth() async {
    QuerySnapshot qs =
        await Firestore.instance.collection('reviews').getDocuments();
    FirebaseUser user = await _auth.currentUser();
    // DocumentSnapshot ds2 =
    //     await Firestore.instance.collection('reviews').document().get();
    // Review review = Review(
    //     isbn: qs["isbn"],
    //     create_by: qs["create_by"],
    //     content: qs["content"],
    //     like: qs["like"]);
    // print(review);
    if (user == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
      // Navigator.pushNamed(context, '/welcome');
    } else {
      DocumentSnapshot ds =
          await Firestore.instance.collection('users').document(user.uid).get();

      setState(() {
        this.user = user;
        // this._reviews = ds2.data;
        this.test =
            User(firstname: ds.data['firstname'], lastname: ds.data['surname']);
      });
    }
  }

  Future logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
  }
}
