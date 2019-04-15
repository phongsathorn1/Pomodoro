import 'package:flutter/foundation.dart';

class User {
  User({
      this.firstname = '',
      this.lastname = ''
  });
  
  String firstname;
  String lastname;

  @override
  String toString() {
    return "firstname: ${this.firstname}, lastname: ${this.lastname}";
  }
}