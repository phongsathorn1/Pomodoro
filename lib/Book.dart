import 'package:flutter/material.dart';
import 'fetching.dart';
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

  List list_name(){
    Welcome items;
    List<Tab> name ;
    for (var i=0;i<items.results.length;i++){
      name.add(Tab(text: items.results[i].listName));
    }
    return name;
}



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: DefaultTabController(
          length: 4,
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
                      FutureBuilder<List<Welcome>>(
                          future: getAllPosts(),
                          builder: (BuildContext context, AsyncSnapshot<List<Welcome>> snapshot){
                            if(snapshot.hasData){
                              return TabBar(tabs: list_name());
                            }
                            else{
                              return Center(child: Text("WTF of api"),);
                            }
                          }
                      ),
//                      TabBar(tabs: [
//                        Tab(text: "Novel"),
//                        Tab(text: "Home"),
//                        Tab(text: "Comic")
//                      ]),
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
