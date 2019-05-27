import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color/color.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:pomodoro/bookpage/Book.dart';
import 'package:pomodoro/bookpage/Model/bookcategory.dart';
import 'package:pomodoro/bookpage/bookDetails.dart';
import 'package:pomodoro/color/colorUI.dart' as prefix0;
import 'package:pomodoro/fonts/fonts.dart';
import 'package:pomodoro/color/colorUI.dart';
import 'package:pomodoro/widgets/detailsPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pomodoro/insert/homepage.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

Firestore _store = Firestore.instance;

class _MyHomePageState extends State<MyHomePage> {
  Stream<QuerySnapshot> location_list;
  int photoIndex = 0;

  List<String> photos = [
    'img/apple.png',
    'img/login.jpg',
    'img/apple2.jpg',
    'img/apple3.jpg'
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      location_list =
          _store.collection("location_detail").orderBy('name').snapshots();
    });
  }

  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : photoIndex;
    });
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

  List<String> imgList = [
    "resource/Label_book.png",
    "resource/Label_timer_2.png",
    "resource/Label_Place.png"
  ];
  @override
  int indexCarousel = 0;
  Widget build(BuildContext context) {
    for (var i in categories) fetchPost(i);

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(tabColor()),
        title: Center(
            child: Text(
          'Reading Guide',
          style: TextStyle(
            fontFamily: GetTextStyle(),
          ),
        )),
      ),
      body: Container(
        color: HexColor(pageBackgroundColor()),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new SizedBox(
                height: 210.0,
                width: double.infinity,
                child: CarouselSlider(
                  onPageChanged: (int index) {
                    setState(() {
                      indexCarousel = index;
                    });
                  },
                  initialPage: 0,
                  autoPlay: true,
                  height: 205,
                  items: imgList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                controller.animateTo((controller.index =
                                    indexCarousel == 0 ? 3 : indexCarousel));
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 0.0),
                              decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(70)),
                              child: Image.asset(
                                i,
                                height: 205,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              new SizedBox(
                height: 15.0,
                width: double.infinity,
              ),
              Card(
                color: HexColor(cardReadingMain()),
                child: Column(
                  children: <Widget>[
                    CustomCardTopic("Reading Place"),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: new Container(
                              height: 480,
                              child: StreamBuilder(
                                stream: location_list,
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            var route = new MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new DetailsPage(
                                                          value: snapshot
                                                              .data.documents
                                                              .elementAt(0),
                                                        ));
                                            Navigator.of(context).push(route);
                                          },
                                          child: CustomCard(
                                            snapshot.data.documents
                                                .elementAt(0)
                                                .data['img_head'],
                                            snapshot.data.documents
                                                .elementAt(0)
                                                .data['name'],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            var route = new MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new DetailsPage(
                                                          value: snapshot
                                                              .data.documents
                                                              .elementAt(1),
                                                        ));
                                            Navigator.of(context).push(route);
                                          },
                                          child: CustomCard(
                                            snapshot.data.documents
                                                .elementAt(1)
                                                .data['img_head'],
                                            snapshot.data.documents
                                                .elementAt(1)
                                                .data['name'],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              new SizedBox(
                height: 15.0,
                width: double.infinity,
              ),
              Card(
                color: HexColor(cardReadingMain()),
                child: Column(
                  children: <Widget>[
                    CustomCardTopic("Reading Book"),
                    new SizedBox(
                      height: 10.0,
                      width: double.infinity,
                    ),
                    new Text(
                      categories[0].title,
                      style:
                          TextStyle(fontFamily: GetTextStyle(), fontSize: 20.0),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 138,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int ind) {
                                  try {
                                    return InkWell(
                                      onTap: () {
                                        var route = new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new BookDetails(
                                                value: allCategory[
                                                        categories[0].encode]
                                                    .results
                                                    .books[ind],
                                              ),
                                        );
                                        Navigator.of(context).push(route);
                                      },
                                      child: CustomBookCard(
                                        allCategory[categories[0].encode]
                                            .results
                                            .books[ind]
                                            .bookImage,
                                      ),
                                    );
                                  } catch (e) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new SizedBox(
                      height: 10.0,
                      width: double.infinity,
                    ),
                    new Text(
                      categories[1].title,
                      style:
                          TextStyle(fontFamily: GetTextStyle(), fontSize: 20.0),
                    ),
                    Container(
                      height: 138,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int ind) {
                          try {
                            return InkWell(
                              onTap: () {
                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new BookDetails(
                                        value: allCategory[categories[1].encode]
                                            .results
                                            .books[ind],
                                      ),
                                );
                                Navigator.of(context).push(route);
                              },
                              child: CustomBookCard(
                                allCategory[categories[1].encode]
                                    .results
                                    .books[ind]
                                    .bookImage,
                              ),
                            );
                          } catch (e) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    new SizedBox(
                      height: 10.0,
                      width: double.infinity,
                    ),
                    new Text(
                      categories[2].title,
                      style:
                          TextStyle(fontFamily: GetTextStyle(), fontSize: 20.0),
                    ),
                    Container(
                      height: 138,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int ind) {
                          try {
                            return InkWell(
                              onTap: () {
                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new BookDetails(
                                        value: allCategory[categories[2].encode]
                                            .results
                                            .books[ind],
                                      ),
                                );
                                Navigator.of(context).push(route);
                              },
                              child: CustomBookCard(
                                allCategory[categories[2].encode]
                                    .results
                                    .books[ind]
                                    .bookImage,
                              ),
                            );
                          } catch (e) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    new SizedBox(
                      height: 10.0,
                      width: double.infinity,
                    ),
                    new Text(
                      categories[3].title,
                      style:
                          TextStyle(fontFamily: GetTextStyle(), fontSize: 20.0),
                    ),
                    Container(
                      height: 138,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int ind) {
                          try {
                            return InkWell(
                              onTap: () {
                                var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new BookDetails(
                                        value: allCategory[categories[2].encode]
                                            .results
                                            .books[ind],
                                      ),
                                );
                                Navigator.of(context).push(route);
                              },
                              child: CustomBookCard(
                                allCategory[categories[3].encode]
                                    .results
                                    .books[ind]
                                    .bookImage,
                              ),
                            );
                          } catch (e) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String description;

  CustomCard(this.title, this.description);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: new Card(
        child: new Column(
          children: <Widget>[
            new Image.network(
              title,
              fit: BoxFit.cover,
              height: 170,
              width: double.infinity,
            ),
            new Padding(
                padding: new EdgeInsets.all(7.0),
                child: new Row(
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.all(7.0),
                      child: new Icon(Icons.account_balance),
                    ),
                    Expanded(
                      child: new Padding(
                        padding: new EdgeInsets.all(7.0),
                        child: new Text(
                          description,
                          style: TextStyle(fontFamily: GetTextStyle()),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class CustomBookCard extends StatelessWidget {
  final String title;

  CustomBookCard(this.title);
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Image.network(title, fit: BoxFit.cover, height: 130, width: 94),
        ],
      ),
    );
  }
}

class CustomCardTopic extends StatelessWidget {
  final String description;

  CustomCardTopic(this.description);
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.all(7.0),
              child: new Row(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Icon(Icons.book),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Text(
                      description,
                      style: TextStyle(fontFamily: GetTextStyle()),
                    ),
                  ),
                ],
              ))
        ],
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
  const Categories('Health', 'health'),
  const Categories('Sports', 'sports'),
  const Categories('Travel', 'travel'),
];
