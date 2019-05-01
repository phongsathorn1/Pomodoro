import 'package:flutter/material.dart';
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



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: DefaultTabController(
          length: categories.length,
          child: MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.blue[200],
                tabBarTheme: TabBarTheme(
                  labelColor: Colors.black,
                )),
            home: Scaffold(
                resizeToAvoidBottomPadding: false,
                appBar: buildBar(context),
                body: Container(
                  child: Column(
                    children: <Widget>[
                  TabBar(
                  isScrollable: true,
                    tabs: categories.map((Categories choice) {
                      return Tab(
                        text: choice.title,
                      );
                    }).toList(),
                  ),
                      FutureBuilder<Book>(
                          future: getPost(),
                          builder: (BuildContext context,
                              AsyncSnapshot<Book> snapshot) {
                            print(snapshot.hasData);
                            if (snapshot.hasData) {
                              if (snapshot.data != null) {
                                return TabBarView(
                                    children: categories.map((Categories choice) {
                                      return null;
                                    }).toList(),);
                              } else {
                                return Center(
                                  child: Text("Null"),
                                );
                              }
                            } else {
                              return Center(
                                child: Text("Error fetching data from api"),
                              );
                            }
                          }),
                      Row(
                        children: <Widget>[
                          new Card(
                            child: new Container(
                              padding: new EdgeInsets.all(10),
                              child: new Column(
                                children: <Widget>[
                                  Image.asset('images/book.jpg',
                                      width: 175, height: 170),
                                  Text("Mindset"),
                                ],
                              ),
                            ),
                          ),
                          new Card(
                            child: new Container(
                              padding: new EdgeInsets.all(10),
                              child: new Column(
                                children: <Widget>[
                                  Image.asset('images/book2.jpg',
                                      width: 175, height: 170),
                                  Text("Principle"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: new Theme(
                  data: Theme.of(context).copyWith(
                    // sets the background color of the `BottomNavigationBar`
                    canvasColor: Colors.blue[200],
                  ),
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), title: Text("Home")),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.access_time),
                          title: Text("Pomodoro")),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.book), title: Text("Book")),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.location_on),
                        title: Text("Location"),
                      ),
                    ],
                    fixedColor: Colors.black,
                    currentIndex: 2,
                  ),
                )
//                labelColor: Colors.blue[200],
//                unselectedLabelColor: Colors.black,
//              ),
                ),
          )),
    );
  }
}

class Categories {
  const Categories(this.title);
  final String title;
}

const List<Categories> categories = const <Categories> [
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
