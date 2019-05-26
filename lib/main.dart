import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/bookpage/bookDetails.dart';
import 'package:pomodoro/color/colorUI.dart';
import 'package:pomodoro/insert/homepage.dart';
import 'package:pomodoro/views/timer_screen.dart';
import 'package:pomodoro/widgets/detailsPage.dart';
import 'package:pomodoro/widgets/locationPage.dart';
import 'package:pomodoro/slides.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        /*
      theme: ThemeData(
        primarySwatch: Colors.grey[350],
      ),*/
        theme: ThemeData(
          fontFamily: 'Sukhumvit',
          cursorColor: Colors.white,
          primaryColor: HexColor(tabColor()),
        ),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => new SliverWithTabBar(),
          '/moreDetail': (BuildContext context) => new DetailsPage(),
          '/locationPage': (BuildContext context) => new LocationPage(),
          '/timerScreen': (BuildContext context) => new TimerScreen(),
          '/bookDetails': (BuildContext context) => BookDetails(),
        });
  }
}
