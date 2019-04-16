import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Book> fetchBook() async{
  final response =
      await http.get('https://www.googleapis.com/books/v1');
  if(response.statusCode == 200){
    return Book.fromJson(json.decode(response.body));
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