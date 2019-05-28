import 'package:flutter/foundation.dart';

class User {
  static String userid;
  static String firstname;
  static String lastname;
  static String email;
  static String photoUrl;

  @override
  String toString() {
    return "userid: ${userid},firstname: ${firstname}, lastname: ${lastname}, email: ${email}";
  }
}
