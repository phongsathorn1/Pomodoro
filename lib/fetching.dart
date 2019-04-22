import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Name> fetchListName() async{
  final response =
      await http.get('https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=AT9JzCxdnatIAYq28d7czaIxXdOMtgpk');
  if(response.statusCode == 200){
    return Name.fromJson(json.decode(response.body));
  }else{
    throw Exception("Error loading data");
  }
}

class Book{
  final String isbn;
  final String title;
  final String content;
  final String author;

  Book({this.isbn, this.title, this.content, this.author});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      isbn: json['isbn'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
    );
  }
}

class Name{
  final String name;

  Name({this.name});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      name: json['list_name']
    );
  }
}
