import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';
import 'package:pomodoro/detailsPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => new ExamplePage(),
        '/moreDetail': (BuildContext context) => new DetailsPage(),
      },
    );
  }
}

class ExamplePage extends StatefulWidget{

  @override
  _ExamplePageState createState() => _ExamplePageState();
}


class _ExamplePageState extends State<ExamplePage>{
  
  final TextEditingController _filter = new TextEditingController();
  //final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredName = new List();
  final dio = new Dio();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text("Search Example");
  

  _ExamplePageState(){
    _filter.addListener((){
      if (_filter.text.isEmpty){
        setState( (){
          _searchText = "";
          filteredName = names;
        });
      }
      else{
        setState(() {
         _searchText = _filter.text; 
        });
      }
    });
  }

  @override
  void initState(){
    this._getName();
    super.initState();
  }

  void _getName() async{
    List tempList = new List();
    final response = await dio.get('https://swapi.co/api/people');
    //final response = json.decode(await new File('/resource/data.json').readAsString());
    print(response.data['result']);
    for (int i = 0; i < response.data['results'].length; i++) {
      tempList.add(response.data['results'][i]);
    }

    setState(() {
      names = tempList;
      filteredName = names;
    });
  }

  void _searchPressed(){
    setState(() {
     if (this._searchIcon.icon == Icons.search){
       this._searchIcon = new Icon(Icons.close);
       this._appBarTitle = new TextField(
         controller: _filter,
         decoration: new InputDecoration(
           prefixIcon: new Icon(Icons.search),
           hintText: 'Search...'
         ),
       );
     }
     else{
       this._searchIcon = new Icon(Icons.search);
       this._appBarTitle = new Text("Search Example");
       filteredName = names;
       _filter.clear();
     }
    });
  }
  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _bulidList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context){
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _bulidList(){
    if (! (_searchText.isEmpty)){
      List tempList = new List();
      for (int i = 0; i<filteredName.length;i++){
        if (filteredName[i]['name'].toLowerCase().contains(_searchText.toLowerCase())){
          tempList.add(filteredName[i]);
        }
      }
      filteredName = tempList;
    }

    var imgTemp = new Image.asset(
      'resource/temp.png',
      height: 200,
    );

    return ListView.builder(
      itemCount: names == null? 0 : filteredName.length,
      itemBuilder: (BuildContext context, int index){
        return new Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              imgTemp,
              Row(
                children: <Widget>[
                  Icon(Icons.album),
                  Text(filteredName[index]['name']),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.alarm),
                  Text("09.30 - 12.30"),
                ],
              ),
              RaisedButton(
                child: Text('more details'),
                color: Colors.redAccent,
                textColor: Colors.white,
                onPressed: (){
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context)
                      => new DetailsPage(value : filteredName[index]),
                  );
                  Navigator.of(context).push(route);
                },
              ),
            ],
          ),
        );
      },
    );
  }

}

