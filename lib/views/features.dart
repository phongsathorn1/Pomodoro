import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class FeaturesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FeaturesScreenState();
  }
}

class FeaturesScreenState extends State<FeaturesScreen> {
  String feature = '';

  @override
  Widget build(BuildContext context) {
    getFileData('assets/feature.txt').then((value){
      setState(() {
        this.feature = value;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Features"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Center(
          child: Text(this.feature),
        ),
      ),
    );
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }
}
