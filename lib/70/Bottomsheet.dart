import 'package:flutter/material.dart';
import 'package:retailtribeadmin/colddrinks.dart';
import 'package:retailtribeadmin/food.dart';

import 'colddrinks.dart';
import 'food.dart';
import 'main.dart';


class MyBottomNavigationBar2 extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar2> {
  int _currentIndex = 0;

  List<Widget> _children = [
    JsonData3(),
    Colddrinks2(),
    Food2(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey, // set the color of unselected items

        selectedItemColor: Colors.brown,
        selectedIconTheme: IconThemeData(
            color: Colors.brown
        ),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.local_drink,),
            label:  "مشروبات ساخنه",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.food_bank_rounded,),
            label:  "مشروبات باردة",

          ),

          BottomNavigationBarItem(
            icon: new Icon(Icons.food_bank_outlined,),
            label:  "أطعمة",

          ),

        ],
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('First Screen'),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Second Screen'),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Third Screen'),
    );
  }
}
