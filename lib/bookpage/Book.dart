import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:pomodoro/bookpage/bookDetails.dart';
import 'package:pomodoro/color/colorUI.dart';
import 'package:pomodoro/fonts/fonts.dart';
import 'package:pomodoro/bookpage/Model/bookcategory.dart';
import 'package:pomodoro/bookpage/Service/book_service.dart';

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
      appBar: AppBar(
        title: Center(
          child: Text(
            'Recommended Books',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: HexColor(tabColor()),
      ),
      body: DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: HexColor(tabColor()),
            unselectedLabelColor: Colors.black,
            labelColor: HexColor(tabColor()),
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
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: snapshot.data.results.books.length,
                        itemBuilder: (BuildContext context, int index) {
                          //get data from each book by snapshot.data.results.books.elementAt(index).'SOMeTHING'
                          return Container(
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 10.0,
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data.results.books
                                                .elementAt(index)
                                                .bookImage),
                                            fit: BoxFit.fill)),
                                  )),
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
