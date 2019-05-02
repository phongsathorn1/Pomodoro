import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pomodoro/widgets/detailsPage.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new SizedBox(
                height: 210.0,
                width: double.infinity,
                child: new Carousel(
                  images: [
                    new ExactAssetImage("resource/read1.jpg", scale: 1),
                    new ExactAssetImage("resource/read3.jpg", scale: 1),
                    new ExactAssetImage("resource/load1.png", scale: 1),
                    new ExactAssetImage("resource/place1.jpg", scale: 1)
                  ],
                )),
            new SizedBox(
              height: 15.0,
              width: double.infinity,
            ),
            new CustomCardTopic("Reading Place"),
            new SizedBox(
              height: 15.0,
              width: double.infinity,
            ),
            new Container(
              height: 480,
              child: StreamBuilder(
                stream: location_list,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        CustomCard(
                            snapshot.data.documents
                                .elementAt(0)
                                .data['img_head'],
                            snapshot.data.documents.elementAt(0).data['name']),
                        CustomCard(
                            snapshot.data.documents
                                .elementAt(1)
                                .data['img_head'],
                            snapshot.data.documents.elementAt(1).data['name']),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text('No data found'),
                    );
                  }
                },
              ),
            ),
            new CustomCardTopic("Reading Book"),
            new SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            new Text(
              "New & Notable",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
            ),
            new SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            new Row(children: <Widget>[
              new CustomBookCard(
                  'https://asset.mebmarket.com/meb/server1/47713/Thumbnail/large.gif?2'),
              new CustomBookCard(
                  'http://ddd.scimath.org/images/stories/flexicontent/item_6757_field_24/m_math-p3.jpg'),
              new CustomBookCard(
                  'http://ddd.scimath.org/images/stories/flexicontent/item_6760_field_24/m_math-p5.jpg'),
              new CustomBookCard(
                  'https://images-se-ed.com/ws/Storage/Originals/978974/186/9789741860920L.jpg?h=1b35a7cb0e2237960b9bffceb6b01061'),
            ]),
            new SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            new Text(
              "be enjoyable to read",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
            ),
            new SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            new Row(children: <Widget>[
              new CustomBookCard(
                  'https://images-se-ed.com/ws/Storage/Originals/978974/960/9789749601136L.gif?h=95df419e9329bad70785e8270a84a8f2'),
              new CustomBookCard(
                  'https://static.getbookie.com/products/images/0000/00/full/923-113990-%E0%B8%9C%E0%B8%88%E0%B8%8D%E0%B8%A0%E0%B8%B1%E0%B8%A2%E0%B8%AD%E0%B8%B1%E0%B8%99%E0%B8%95%E0%B8%A3%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%81%E0%B8%A5%E0%B9%89%E0%B8%95%E0%B8%B1%E0%B8%A7.jpg'),
              new CustomBookCard(
                  'https://static.getbookie.com/products/images/0000/00/full/921-113988-%E0%B8%9C%E0%B8%88%E0%B8%8D%E0%B8%A0%E0%B8%B1%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B8%96%E0%B9%89%E0%B8%B3%E0%B8%A1%E0%B8%B7%E0%B8%94.jpg'),
              new CustomBookCard(
                  'http://www.chulabook.com/images/book-400/9789741647224.jpg'),
            ]),
            new SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            new Text(
              "be fun to read",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
            ),
            new SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            new Row(children: <Widget>[
              new CustomBookCard(
                  'https://images-se-ed.com/ws/Storage/Originals/978616/780/9786167808017L.jpg?h=26f9c330803c62e7fb7e65d21bdb1835'),
              new CustomBookCard(
                  'http://www.stabundamrong.go.th/library/images/book_pic/2553/Jun53.5.jpg'),
              new CustomBookCard(
                  'https://images-se-ed.com/ws/Storage/Originals/978616/275/9786162756757L.jpg?h=d93d9d7a990f7d6e67d39979f3641367'),
              new CustomBookCard(
                  'http://www.oknation.net/blog/home/blog_data/149/1149/images/hajhakreng1.jpg'),
            ])
          ],
        ),

        // mainAxisAlignment: MainAxisAlignment.start,
        // children: <Widget>[
        //   Center(
        //     child: Stack(
        //       children: <Widget>[
        //         Container(
        //           decoration: BoxDecoration(
        //               image: DecorationImage(
        //                   image: AssetImage(photos[photoIndex]),
        //                   fit: BoxFit.fitWidth)),
        //           height: 200.0,
        //         ),
        //         Positioned(
        //           top: 375.0,
        //           left: 25.0,
        //           right: 25.0,
        //           child: SelectedPhoto(numberOfDots: photos.length, photoIndex: photoIndex),
        //         )
        //       ],
        //     ),
        //   ),
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       RaisedButton(
        //         child: Text('Next'),
        //         onPressed: _nextImage,
        //         elevation: 5.0,
        //         color: Colors.green,
        //       ),
        //       SizedBox(width: 10.0),
        //       RaisedButton(
        //         child: Text('Prev'),
        //         onPressed: _previousImage,
        //         elevation: 5.0,
        //         color: Colors.blue,
        //       )
        //     ],
        //   ),
        //   new ListView(
        //       shrinkWrap: true,
        //       padding: const EdgeInsets.all(20.0),
        //       children: List.generate(choices.length, (index) {
        //           return Center(
        //             child: ChoiceCard(choice: choices[index], item: choices[index]),
        //           );
        //       }
        //     ),
        //   ),
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
                          style: new TextStyle(fontSize: 18.0),
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
          new Image.network(title, fit: BoxFit.cover, height: 120, width: 94),
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
                      style: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 20.0),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

// class SelectedPhoto extends StatelessWidget {

//   final int numberOfDots;
//   final int photoIndex;

//   SelectedPhoto({this.numberOfDots, this.photoIndex});

//   Widget _inactivePhoto() {
//     return new Container(
//       child: new Padding(
//         padding: const EdgeInsets.only(left: 3.0, right: 3.0),
//         child: Container(
//           height: 8.0,
//           width: 8.0,
//           decoration: BoxDecoration(
//             color: Colors.grey,
//             borderRadius: BorderRadius.circular(4.0)
//           ),
//         ),
//       )
//     );
//   }

//   Widget _activePhoto() {
//     return Container(
//       child: Padding(
//         padding: EdgeInsets.only(left: 3.0, right: 3.0),
//         child: Container(
//           height: 10.0,
//           width: 10.0,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(5.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey,
//                 spreadRadius: 0.0,
//                 blurRadius: 2.0
//               )
//             ]
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildDots() {
//     List<Widget> dots = [];

//     for(int i = 0; i< numberOfDots; ++i) {
//       dots.add(
//         i == photoIndex ? _activePhoto(): _inactivePhoto()
//       );
//     }

//     return dots;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: _buildDots(),
//       ),
//     );
//   }
// }

// class Choice {
//   const Choice({this.title, this.icon});

//   final String title;
//   final IconData icon;
// }

// const List<Choice> choices = const <Choice>[
//   const Choice(title: 'This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car.', icon: Icons.directions_car),
//   const Choice(title: 'This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle. This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle. This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle.', icon: Icons.directions_bike),
//   const Choice(title: 'This is a Boat, because its a Boat. So, it\'s a Boat', icon: Icons.directions_boat),
//   const Choice(title: 'This is a Bus, because its a Bus. So, it\'s a Bus', icon: Icons.directions_bus),
//   const Choice(title: 'This is a Train, because its a Train. So, it\'s a Train', icon: Icons.directions_railway),
//   const Choice(title: 'This is a Walk, because its a Walk. So, it\'s a Walk', icon: Icons.directions_walk),
//   const Choice(title: 'This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car.', icon: Icons.directions_car),
//   const Choice(title: 'This is a Car, because its a car. So, it\'s a car', icon: Icons.directions_car),
//   const Choice(title: 'This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle', icon: Icons.directions_bike),
//   const Choice(title: 'This is a Boat, because its a Boat. So, it\'s a Boat', icon: Icons.directions_boat),
//   const Choice(title: 'This is a Bus, because its a Bus. So, it\'s a Bus', icon: Icons.directions_bus),
//   const Choice(title: 'This is a Train, because its a Train. So, it\'s a Train', icon: Icons.directions_railway),
//   const Choice(title: 'This is a Walk, because its a Walk. So, it\'s a Walk', icon: Icons.directions_walk),
//   const Choice(title: 'This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car.', icon: Icons.directions_car),
//   const Choice(title: 'This is a Car, because its a car. So, it\'s a car', icon: Icons.directions_car),
//   const Choice(title: 'This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle', icon: Icons.directions_bike),
//   const Choice(title: 'This is a Boat, because its a Boat. So, it\'s a Boat', icon: Icons.directions_boat),
//   const Choice(title: 'This is a Bus, because its a Bus. So, it\'s a Bus', icon: Icons.directions_bus),
//   const Choice(title: 'This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car.', icon: Icons.directions_car),
//   const Choice(title: 'This is a Train, because its a Train. So, it\'s a Train', icon: Icons.directions_railway),
//   const Choice(title: 'This is a Walk, because its a Walk. So, it\'s a Walk', icon: Icons.directions_walk),
//   const Choice(title: 'This is a Car, because its a car. So, it\'s a car', icon: Icons.directions_car),
//   const Choice(title: 'This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle', icon: Icons.directions_bike),
//   const Choice(title: 'This is a Boat, because its a Boat. So, it\'s a Boat', icon: Icons.directions_boat),
//   const Choice(title: 'This is a Bus, because its a Bus. So, it\'s a Bus', icon: Icons.directions_bus),
//   const Choice(title: 'This is a Train, because its a Train. So, it\'s a Train', icon: Icons.directions_railway),
//   const Choice(title: 'This is a Walk, because its a Walk. So, it\'s a Walk', icon: Icons.directions_walk),
// ];

// class ChoiceCard extends StatelessWidget {
//   const ChoiceCard(
//       {Key key, this.choice, this.onTap, @required this.item, this.selected: false}
//     ) : super(key: key);

//   final Choice choice;
//   final VoidCallback onTap;
//   final Choice item;
//   final bool selected;

//   @override
//   Widget build(BuildContext context) {
//     TextStyle textStyle = Theme.of(context).textTheme.display1;
//     if (selected)
//       textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
//         return Card(
//           color: Colors.white,
//           child: Row(
//               children: <Widget>[
//                 new Container(
//                   padding: const EdgeInsets.all(8.0),
//                   alignment: Alignment.topLeft,
//                   child: Icon(choice.icon, size:80.0, color: textStyle.color,)),
//                 new Expanded(
//                   child: new Container(
//                   padding: const EdgeInsets.all(10.0),
//                   alignment: Alignment.topLeft,
//                   child:
//                     Text(choice.title, style: null, textAlign: TextAlign.left, maxLines: 5,),
//                   )
//                 ),
//             ],
//            crossAxisAlignment: CrossAxisAlignment.start,
//           )
//     );
//   }
// }
