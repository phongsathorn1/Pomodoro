import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  FirebaseUser user;

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
              child: Text("Drawer Header"),
              decoration: BoxDecoration(
                color: Colors.blue,
              )
            ),
            ListTile(
              title: Text("Features"),
              onTap: () {
                Navigator.pushNamed(context, '/features');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, 
                color: Colors.red
              ),
              title: Text(
                "Logout", 
                style: TextStyle(
                  color: Colors.red
                )
              ),
              onTap: () {
                this.logout(context);
              },
            )
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text("Place")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            title: Text("Pomodoro")
          )
        ]
      ),
    );
  }

  Future checkAuth() async {
    FirebaseUser user = await _auth.currentUser();
    if(user == null){
      Navigator.pushNamed(context, '/welcome');
    }
    print(user);
  }

  Future logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamed(context, '/welcome');
  }
}