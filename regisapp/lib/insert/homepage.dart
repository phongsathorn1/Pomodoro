import 'package:flutter/material.dart';
import 'package:regisapp/insert/mainpage.dart';
import 'package:carousel_pro/carousel_pro.dart';

class SliverWithTabBar extends StatefulWidget {
  @override
  _SliverWithTabBarState createState() => _SliverWithTabBarState();
}

class _SliverWithTabBarState extends State<SliverWithTabBar> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("#f3b7c3"),
            title: new Text("Reading Guide"),
            actions: <Widget>[
              IconButton(
                padding: const EdgeInsets.only(right: 10.0),
                icon: Icon(Icons.account_box),
                // onPressed: _airDress,
              ),
            ],
            bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.alarm)),
                  Tab(icon: Icon(Icons.account_balance)),
                  Tab(icon: Icon(Icons.book)),
                ],
                controller: controller,
            ),
          ),
          body: TabBarView(
            children: [
              new MyHomePage(),
              new MyHomePage(),
              new MyHomePage(),
              new MyHomePage(),
            ],
            controller: controller,
          ),
        );
//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return <Widget>[
//             SliverAppBar(
//               pinned: false,
//               backgroundColor: Colors.white,
//               flexibleSpace: FlexibleSpaceBar(
//                 collapseMode: CollapseMode.pin,
//                 background: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       height: 110.0,
//                       width: double.infinity,
                      // decoration: new BoxDecoration(
                      //   image: DecorationImage(
                      //     image: new AssetImage('img/book.jpg'),
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Text(
//                         'Reading Guide',
//                         style: TextStyle(fontSize: 25.0),
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           Icon(Icons.share),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10.0),
//                             child: Icon(Icons.account_box),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               expandedHeight: 220.0,
//               bottom: TabBar(
//                 indicatorColor: Colors.black,
//                 labelColor: Colors.black,
//                 tabs: [
//                   Tab(icon: Icon(Icons.home)),
//                   Tab(icon: Icon(Icons.alarm)),
//                   Tab(icon: Icon(Icons.account_balance)),
//                   Tab(icon: Icon(Icons.book)),
//                 ],
//                 controller: controller,
//               ),
//             )
//           ];
//         },
//         body: TabBarView(
//           children: [
//             new MyHomePage(),
//             new MyHomePage(),
//             new MyHomePage(),
//             new MyHomePage(),
//           ],
//           controller: controller,
//         ),
//       ),
//     );
  }
}


// class Homepage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return Homepagework();
//   }

// }

// class Homepagework extends State<Homepage> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return DefaultTabController(
//       length: 5,
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(60.0),
//           child: AppBar(
//            centerTitle: false,
//             backgroundColor: HexColor("ffdae9"),
//             title: new Text(
//               "Reading Guide",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//             actions: <Widget>[
//               Padding(
//                 padding: EdgeInsets.only(right: 10.0),
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white, //remove this when you add image.
//                   ),
//                   child: CachedNetworkImage(
//                                       width: 120,
//                                       height: 120,
//                                       fit: BoxFit.cover,
//                                       imageUrl: "imageUrl goes here",
//                                     ),
//                                   ),
//                                 )
//                               ],
//                           ),
//         ),
                      //     bottomNavigationBar: Container(
                      //         color: HexColor("ffdae9"),
                      //         child: TabBar(
                      //           tabs: [
                      //           Tab(icon: Icon(Icons.home)),
                      //           Tab(icon: Icon(Icons.alarm)),
                      //           Tab(icon: Icon(Icons.account_balance)),
                      //           Tab(icon: Icon(Icons.book)),
                      //           ],
                      //         ),
                      //       ),
                      //     body: 
                      //   ),
                      // );
//                     }
                  
//                     CachedNetworkImage({int width, int height, BoxFit fit, String imageUrl}) {}
// }

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

