import 'package:flutter/material.dart';
import 'package:lhu/page/account_page.dart';
import 'package:lhu/page/favourite_page.dart';
import 'package:lhu/page/home_page.dart';
import 'package:lhu/shared/color_page.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Account'),
  ];
  int _selectedIndex = 0;
  List<Widget> widgetList = [
    HomePage(),
    FavouritePage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lhu'),
      ),
      body: Center(child: widgetList[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.primaryColor,
        items: bottomItem,
        currentIndex: _selectedIndex,
        onTap: (value) {
          _onItemTapped(value);
        },
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
