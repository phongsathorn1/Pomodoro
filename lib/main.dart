import 'package:flutter/material.dart';
import 'package:pomodoro/Book.dart';
import 'package:pomodoro/bookDetails.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => BookPage(),
        '/bookDetails': (BuildContext context) => BookDetails(),
      },
    );
  }
}
