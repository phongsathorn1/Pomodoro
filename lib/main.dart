import 'package:flutter/material.dart';

import 'views/home.dart';
import 'views/login.dart';
import 'views/register.dart';
import 'views/welcome.dart';
import 'views/forgotPassword.dart';
import 'views/features.dart';
import 'views/addProfilePic.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/forgot': (context) => ForgotScreen(),
        '/features': (context) => FeaturesScreen(),
        '/addProfilePic': (context) => AddProfilePicScreen()
      },
    );
  }
}
