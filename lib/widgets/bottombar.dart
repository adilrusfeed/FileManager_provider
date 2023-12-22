// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:file_manager/controller/bottom_provider.dart';
import 'package:file_manager/view/main_screens/add_screen.dart';
import 'package:file_manager/view/main_screens/chart_screen.dart';
import 'package:file_manager/view/main_screens/home_screen.dart';
import 'package:file_manager/view/main_screens/recent_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  BottomBar({Key? key});

  final pages = [HomeScreen(), RecentScreen(), AddScreen(), ChartScreen()];

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: pages[bottomProvider.myindex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Color.fromARGB(255, 0, 0, 0),
          animationDuration: Duration(milliseconds: 500),
          index: bottomProvider.myindex,
          onTap: (index) {
            bottomProvider.setIndex(index);
          },
          items: [
            Icon(
              Icons.home,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 30,
            ),
            Icon(
              Icons.history,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.bar_chart_sharp,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
