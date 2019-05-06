import 'package:flutter/material.dart';
import 'Book.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => BookPage(),
      },
    );
  }
}
