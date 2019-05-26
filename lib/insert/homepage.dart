import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/bookpage/Book.dart';
import 'package:pomodoro/color/colorUI.dart';
import 'package:pomodoro/feature/feature.dart';
import 'package:pomodoro/fonts/fonts.dart';
import 'package:pomodoro/insert/mainpage.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/widgets/locationPage.dart';
import 'package:pomodoro/views/timer_screen.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeState extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

int tabIndex = 0;
TabController controller;

class _HomeScreen extends State<HomeState> with SingleTickerProviderStateMixin {
  FirebaseUser user;
  User test = User();
  int _navIndex = 0;
  @override
  void initState() {
    super.initState();
    checkAuth();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: tabIndex,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor(tabColor()),
          title: Center(
              child: Text(
            'Reading Guide',
            style: TextStyle(
              fontFamily: GetTextStyle(),
            ),
          )),
        ),
        bottomNavigationBar: Container(
          color: HexColor(tabColor()),
          child: TabBar(
            indicatorColor: Colors.white,
            onTap: (index) {
              setState(() {
                tabIndex = index;
              });
            },
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.alarm)),
              Tab(icon: Icon(Icons.account_balance)),
              Tab(icon: Icon(Icons.book)),
            ],
            controller: controller,
          ),
        ),
        body: TabBarView(
          children: [
            new MyHomePage(),
            new TimerScreen(),
            new LocationPage(),
            new BookPage(),
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
                                      image: AssetImage('resource/profile.png'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            Text(
                              "${User.firstname} ${User.lastname}",
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
              leading: Icon(Icons.build),
              title: Text("Edit Profile"),
              onTap: () {
                Navigator.pushNamed(context, '/profileSetup');
              },
            ),
            ListTile(
              leading: Icon(Icons.new_releases),
              title: Text("Features"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IntroScreen(),
                  ),
                );
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
      ),
    );
  }

  Future checkAuth() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      // Navigator.pushNamed(context, '/welcome');
    } else {
      DocumentSnapshot ds =
          await Firestore.instance.collection('users').document(user.uid).get();

      setState(() {
        this.user = user;
        User.firstname = ds.data['firstname'];
        User.lastname = ds.data['surname'];
        User.email = ds.data['email'];
        User.userid = ds.data['uid'];
      });
    }
  }

  Future logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}
