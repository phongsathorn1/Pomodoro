import 'package:flutter/material.dart';

class BookRecommended extends StatelessWidget {
//  String searchText = "";
//  Icon _searchIcon = new Icon(Icons.search);
//  Widget _appBarTitle = new Text( 'Search Example' );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 4,
          child: MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.blue[200]
            ),
            home: Scaffold(
                resizeToAvoidBottomPadding: false,
              body: SearchBar(),
                bottomNavigationBar: new Theme(
                  data: Theme.of(context).copyWith(
                    // sets the background color of the `BottomNavigationBar`
                    canvasColor: Colors.blue[200],
                  ),
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        title: Text("Home")
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.access_time),
                        title: Text("Pomodoro")
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.book),
                        title: Text("Book")
                      ),
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
class SearchBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchState();
  }

}
class SearchState extends State<SearchBar>{
  final TextEditingController _filter = new TextEditingController();
  Icon searchIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text( 'Recommended Book' );
  void searchPressed() {
    setState(() {
      if (this.searchIcon.icon == Icons.search) {
        this.searchIcon = new Icon(Icons.close);
        this.appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              hintText: 'Search Book...'
          ),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: searchIcon, onPressed: searchPressed),
        title: appBarTitle,
      ),
    );
  }


}


