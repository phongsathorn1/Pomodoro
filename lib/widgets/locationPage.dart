import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:pomodoro/fonts/fonts.dart';
import 'package:pomodoro/widgets/detailsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pomodoro/color/colorUI.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

Firestore _store = Firestore.instance;

class _LocationPageState extends State<LocationPage> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = new List();
  List filteredName = new List();
  Icon _searchIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget _appBarTitle = new Text(
    "Search Locations",
    style: TextStyle(
      fontFamily: GetTextStyle(),
      color: Colors.white,
    ),
  );
  Stream<QuerySnapshot> location_list;
  List<Icon> floatIcon;
  List<Text> floatText;
  int floatState;

  _LocationPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredName = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      location_list =
          _store.collection("location_detail").orderBy('name').snapshots();
      floatIcon = [Icon(Icons.filter_list), Icon(Icons.star)];
      floatText = [Text('sort by name'), Text('sort by rate')];
      floatState = 0;
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(
          Icons.close,
          color: Colors.white,
        );
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            prefixIcon: new Icon(
              Icons.search,
              color: Colors.white ,
            ),
            prefixStyle: TextStyle(
              color: Colors.white,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            hintText: 'search locations...',
          ),
          style: TextStyle(
            fontFamily: GetTextStyle(),
            color: Colors.white,
          ),
        );
      } else {
        this._searchIcon = new Icon(
          Icons.search,
          color: Colors.white,
        );
        this._appBarTitle = new Text(
          "Search locations",
          style: TextStyle(
            fontFamily: GetTextStyle(),
            color: Colors.white,
          ),
        );
        filteredName = names;
        _searchText = "";
        _filter.clear();
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      floatingActionButton: _buildFloatingButton(),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor: HexColor(tabColor()),
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton.extended(
      icon: floatIcon[floatState],
      label: floatText[floatState],
      onPressed: () {
        setState(() {
          floatState = 1 - floatState;
          if (floatState == 0) {
            location_list = _store
                .collection("location_detail")
                .orderBy('name')
                .snapshots();
          } else {
            location_list = _store
                .collection("location_detail")
                .orderBy('rate', descending: true)
                .snapshots();
          }
        });
      },
    );
  }

  Widget _buildList() {
    return Container(
      color: HexColor(pageBackgroundColor()),
      child: StreamBuilder(
        stream: location_list,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              //itemCount: names == null? 0 : filteredName.length,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                if (_searchText.isNotEmpty &&
                    !snapshot.data.documents
                        .elementAt(index)
                        .data['name']
                        .toLowerCase()
                        .contains(_searchText.toLowerCase()))
                  return new Container();
                else {
                  return new Card(
                    color: Colors.red[800],
                    margin: EdgeInsets.only(top: 35, left: 15, right: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: new ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              snapshot.data.documents
                                  .elementAt(index)
                                  .data['img_head'],
                              height: 150,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 15, top: 10, right: 15, bottom: 0),
                          transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                  Expanded(
                                    child: Text(
                                      ' ' +
                                          snapshot.data.documents
                                              .elementAt(index)
                                              .data['name'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: GetTextStyle(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.access_time),
                                  Text(
                                    ' ' +
                                        snapshot.data.documents
                                            .elementAt(index)
                                            .data['open_day'] +
                                        " " +
                                        snapshot.data.documents
                                            .elementAt(index)
                                            .data['time'],
                                    style: TextStyle(
                                      fontFamily: GetTextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'คะแนน: ',
                                    style: TextStyle(
                                      fontFamily: GetTextStyle(),
                                    ),
                                  ),
                                  FlutterRatingBarIndicator(
                                    rating: double.parse(
                                        "${snapshot.data.documents.elementAt(index).data['rate']}"),
                                    itemCount: 5,
                                    itemSize: 15,
                                    fillColor: Colors.amber,
                                    emptyColor: Colors.amber.withAlpha(70),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(0, -10, 0),
                          child: RaisedButton(
                            child: Text(
                              'details',
                              style: TextStyle(
                                fontFamily: GetTextStyle(),
                              ),
                            ),
                            color: Colors.redAccent,
                            textColor: Colors.white,
                            onPressed: () {
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new DetailsPage(
                                        value: snapshot.data.documents
                                            .elementAt(index)),
                              );
                              Navigator.of(context).push(route);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            return Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
