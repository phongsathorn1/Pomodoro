import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/bookcategory.dart';
import 'Service/book_service.dart';
import 'package:pomodoro/bookDetails.dart';

class BookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BookState();
  }
}

Map<String, Book> allCategory = new Map<String, Book>();

class BookState extends State<BookPage> {
  Book booklist = new Book();
  final TextEditingController _filter = new TextEditingController();
  Icon searchIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text('Recommended Book');
  void searchPressed() {
    setState(() {
      if (this.searchIcon.icon == Icons.search) {
        this.searchIcon = new Icon(Icons.close);
        this.appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(hintText: 'Search Book...'),
        );
      } else {
        this.searchIcon = new Icon(Icons.search);
        this.appBarTitle = new Text('Recommended Book');
//        filteredNames = names;
        _filter.clear();
      }
    });
  }

  @override
  Widget buildBar(BuildContext context) {
    return new AppBar(
        leading: IconButton(icon: searchIcon, onPressed: searchPressed),
        title: appBarTitle,
        backgroundColor: Colors.blue[200]);
  }

  Future<Book> fetchPost(Categories name) async {
    if (allCategory[name.encode] != null) {
      return allCategory[name.encode];
    } else {
      final response = await http.get(
          'https://api.nytimes.com/svc/books/v3/lists/current/' +
              name.encode +
              '.json?api-key=AT9JzCxdnatIAYq28d7czaIxXdOMtgpk');
      if (response.statusCode == 200) {
        setState(() {
          allCategory[name.encode] = Book.fromJson(json.decode(response.body));
        });
        return allCategory[name.encode];
      } else {
        throw Exception('Failed to load post');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: buildBar(context),
      body: DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.blue[200],
            isScrollable: true,
            tabs: categories.map((Categories choice) {
              return Tab(
                text: choice.title,
              );
            }).toList(),
          ),
          body: TabBarView(
            children: categories.map((Categories choice) {
              return FutureBuilder<Book>(
                future: fetchPost(choice),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      ///!!!!!!!!!!!!!!!!!!!!!!!! DATA FROM API !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                      child: ListView.builder(
                        itemCount: snapshot.data.results.books.length,
                        itemBuilder: (BuildContext context, int index) {
                          //get data from each book by snapshot.data.results.books.elementAt(index).'SOMeTHING'
                          return Card(
                            child: InkWell(
                              onTap: () {
                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new BookDetails(
                                          value: snapshot.data.results.books
                                              .elementAt(index)),
                                );
                                Navigator.of(context).push(route);
                              },
                              child: Column(
                                children: <Widget>[
                                  Image.network(
                                      snapshot.data.results.books
                                          .elementAt(index)
                                          .bookImage,
                                      width: 250,
                                      height: 300),
                                  Text(
                                      snapshot.data.results.books
                                          .elementAt(index)
                                          .title,
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    );
                  } else {
                    return Center(
                      child: new CircularProgressIndicator(),
                    );
                  }
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Categories {
  const Categories(this.title, this.encode);
  final String title;
  final String encode;
}

const List<Categories> categories = const <Categories>[
  const Categories('Series Books', 'series-books'),
  const Categories('Manga', 'manga'),
  const Categories('Animals', 'animals'),
  const Categories('Health', 'health'),
  const Categories('Science', 'science'),
  const Categories('Sports', 'sports'),
  const Categories('Travel', 'travel'),
];
