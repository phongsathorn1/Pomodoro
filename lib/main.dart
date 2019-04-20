import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:dio/dio.dart';
import 'package:pomodoro/widgets/detailsPage.dart';
import 'package:pomodoro/widgets/locationPage.dart';

void main() => runApp(new MyApp());

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
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => new LocationPage(),
        '/moreDetail': (BuildContext context) => new DetailsPage(),
      },
    );
  }
}

