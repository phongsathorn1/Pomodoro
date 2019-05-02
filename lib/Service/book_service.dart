import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:pomodoro/Model/bookcategory.dart';
import 'dart:io';


String url = 'https://api.nytimes.com/svc/books/v3/lists/';
String api = '?api-key=AT9JzCxdnatIAYq28d7czaIxXdOMtgpk';
String url_post = 'https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=AT9JzCxdnatIAYq28d7czaIxXdOMtgpk';

Future<List<Book>> getAllPosts() async {
  final response = await http.get(url);
  print(response.body);
  List<Book> x = allPostsFromJson(response.body);
  return x;
}

Future<Book> getPost() async{
  final response = await http.get('https://api.nytimes.com/svc/books/v3/lists/current/e-book-fiction.json?api-key=AT9JzCxdnatIAYq28d7czaIxXdOMtgpk');
  //print(response.body);
  return bookFromJson(response.body);
}

Future<Book> getBook(String categories) async{
  final response = await http.get(url+'current/'+categories+'.json'+api);
  print(response.body);
  return bookFromJson(response.body);
}

Future<http.Response> createPost(Book book) async{
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: bookToJson(book)
  );
  return response;
}