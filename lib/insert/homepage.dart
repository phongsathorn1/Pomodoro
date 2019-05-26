import 'package:flutter/material.dart';
import 'package:pomodoro/bookpage/Book.dart';
import 'package:pomodoro/color/colorUI.dart';
import 'package:pomodoro/insert/mainpage.dart';
import 'package:pomodoro/widgets/locationPage.dart';
import 'package:pomodoro/views/timer_screen.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

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
          color: HexColor(tabColor()),
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
