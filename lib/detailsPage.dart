import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget{
  DetailsPage({Key key, this.value}) :super (key:key);
  var value;
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>{

  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
        title: new Text('More details'),
      ),
      body: Text("${widget.value['name']}"),
    );
  }
}