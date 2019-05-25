import 'package:flutter/material.dart';
import 'package:pomodoro/bookpage/Book.dart';
import 'package:pomodoro/insert/mainpage.dart';
import 'package:pomodoro/widgets/locationPage.dart';
import 'package:pomodoro/views/timer_screen.dart';

class SliverWithTabBar extends StatefulWidget {
  @override
  _SliverWithTabBarState createState() => _SliverWithTabBarState();
}

int tabIndex = 0;
TabController controller;

class _SliverWithTabBarState extends State<SliverWithTabBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: tabIndex,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: HexColor("#f3b7c3"),
          child: TabBar(
            onTap: (index) {
              setState(() {
                tabIndex = index;
              });
            },
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
            new TimerScreen(),
            new LocationPage(),
            new BookPage(),
          ],
          controller: controller,
        ),
      ),
    );
    ;
  }
}

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
