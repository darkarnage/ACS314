import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/Dashboard.dart';
import 'package:flutter_application_1/views/CategoryScreen.dart';
import 'package:flutter_application_1/views/ListScreen.dart';
import 'package:flutter_application_1/views/ProfileScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    CategoryScreen(),
    ListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe App"), centerTitle: true),

      body: _pages[_pageIndex],

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        index: _pageIndex,
        items: const <Widget>[
          Icon(Icons.dashboard, size: 30),
          Icon(Icons.category, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}
