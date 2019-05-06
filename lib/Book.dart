import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/bookcategory.dart';
import 'Service/book_service.dart';

class BookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BookState();
  }
}

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

  Future<Book> fetchPost() async {
    final response = await http.get(
        'https://api.nytimes.com/svc/books/v3/lists/current/e-book-fiction.json?api-key=AT9JzCxdnatIAYq28d7czaIxXdOMtgpk');
    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
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
                future: fetchPost(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      ///!!!!!!!!!!!!!!!!!!!!!!!! DATA FROM API !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                      child: ListView.builder(
                        itemCount: snapshot.data.results.books.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Column(
                              children: <Widget>[
                                Text('Title : ' +
                                    snapshot.data.results.books
                                        .elementAt(index)
                                        .title),
                              ],
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
  const Categories(this.title);
  final String title;
}

const List<Categories> categories = const <Categories>[
  const Categories('Series Books'),
  const Categories('Manga'),
  const Categories('Animals'),
  const Categories('Health'),
  const Categories('Science'),
  const Categories('Sports'),
  const Categories('Travel'),
];

class BookCard extends StatelessWidget {
  const BookCard({Key key, this.book}) : super(key: key);

  final Categories book;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Text(book.title, style: textStyle),
        ],
      ),
    );
  }
}
