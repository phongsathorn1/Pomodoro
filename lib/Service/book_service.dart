import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:pomodoro/Model/bookcategory.dart';
import 'dart:io';

String url = 'https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=AT9JzCxdnatIAYq28d7czaIxXdOMtgpk';

Future<List<Welcome>> getAllPosts() async {
  final response = await http.get(url);
  print(response.body);
  List<Welcome> x = allPostsFromJson(response.body);
  print(x);
  return x;
}

Future<Welcome> getPost() async{
  final response = await http.get(url);
  return welcomeFromJson(response.body);
}

Future<http.Response> createPost(Welcome welcome) async{
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: welcomeToJson(welcome)
  );
  return response;
}