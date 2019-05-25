import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pomodoro/fonts/fonts.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.value}) : super(key: key);
  var value;
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  GoogleMapController myController;
  Set<Marker> markers = new Set<Marker>();
  List<String> listImg = new List<String>();

  @override
  void initState() {
    super.initState();

    for (String i in List.from(widget.value['img_review'])) {
      listImg.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    markers.add(new Marker(
      markerId: MarkerId('mark'),
      draggable: false,
      position: LatLng(
          widget.value['latlng'].latitude, widget.value['latlng'].longitude),
    ));

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.value['img_head'],
                  fit: BoxFit.cover,
                ),
                title: Text(
                  widget.value['name'],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: GetTextStyle(),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          transform: Matrix4.translationValues(0, -20, 0),
          color: Colors.black.withAlpha(30),
          child: ListView(
            children: <Widget>[
              //ชื่อ
              Card(
                  margin: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                  child: Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                'ชื่อสถานที่',
                                style: TextStyle(
                                  fontFamily: GetTextStyle(),
                                ),
                              ),
                            ),
                          ),
                          color: Colors.blue.withAlpha(50),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                widget.value['name'],
                                style: TextStyle(
                                  fontFamily: GetTextStyle(),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              //เวลาเปิด-ปิด
              Card(
                  margin: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                  child: Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 70,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                'เวลาเปิด - ปิด',
                                style: TextStyle(
                                  fontFamily: GetTextStyle(),
                                ),
                              ),
                            ),
                          ),
                          color: Colors.blue.withAlpha(50),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                widget.value['open_day'] +
                                    '  ' +
                                    widget.value['time'],
                                style: TextStyle(
                                  fontFamily: GetTextStyle(),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              //โทร
              Card(
                  margin: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                  child: Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 70,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                '    ติดต่อ    ',
                                style: TextStyle(
                                  fontFamily: GetTextStyle(),
                                ),
                              ),
                            ),
                          ),
                          color: Colors.blue.withAlpha(50),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                widget.value['tel'],
                                style: TextStyle(
                                  fontFamily: GetTextStyle(),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              //คะแนน
              Card(
                  margin: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                  child: Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 70,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                '   คะแนน : ${widget.value['rate']}  ',
                                style: TextStyle(
                                  fontFamily: GetTextStyle(),
                                ),
                              ),
                            ),
                          ),
                          color: Colors.blue.withAlpha(50),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: FlutterRatingBarIndicator(
                                rating: widget.value['rate'],
                                itemCount: 5,
                                itemSize: 20,
                                fillColor: Colors.amber,
                                emptyColor: Colors.amber.withAlpha(70),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              //map
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  height: 150,
                  width: 250,
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      setState(() {
                        myController = controller;
                      });
                    },
                    initialCameraPosition: CameraPosition(
                        target: LatLng(widget.value['latlng'].latitude,
                            widget.value['latlng'].longitude),
                        zoom: 15.0),
                    markers: markers,
                  ),
                ),
              ),
              //image slider
              Stack(
                children: <Widget>[
                  CarouselSlider(
                    initialPage: 0,
                    height: 400,
                    enableInfiniteScroll: false,
                    items: listImg.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(70)),
                            child: Image.network(
                              i,
                              height: 400,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
