import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/utils.dart';

class DetailsPage extends StatefulWidget{
  DetailsPage({Key key, this.value}) :super (key:key);
  var value;
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>{

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "${widget.value['name']}",
          style: textStyleLight(fontSize: 26),
          textAlign: TextAlign.start,
           overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.grey[350],
      ),
      body: Text("${widget.value['name']}", style: textStyleRegular(fontSize: 16, color: Colors.black), ),
    );
  }
}


/*  

Text("${widget.value['name']}"),

*/