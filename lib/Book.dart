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

  Future<Book> fetchPost(Categories name) async {
    final response = await http.get(
        'https://api.nytimes.com/svc/books/v3/lists/current/'+ name.encode +'.json?api-key=AT9JzCxdnatIAYq28d7czaIxXdOMtgpk');
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
                                child: Column(
                                  children: <Widget>[
                                    Image.network(snapshot.data.results.books.elementAt(index).bookImage, width: 250, height: 300),
                                    Text(snapshot.data.results.books.elementAt(index).title, style: TextStyle(fontSize: 15)),
                                    ButtonTheme.bar(
                                      child: ButtonBar(
                                        children: <Widget>[
                                          FlatButton(
                                            child: Text('Read More'),
                                            onPressed: (){
                                              Navigator.pushNamed(context, "/detail");
                                            },
                                          )
                                        ],
                                      ),
                                    )
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

