// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/TabScreens/explore.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ExploreScreen(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.lightPink,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/exploreblack.png')),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/inboxblack.png')),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/bookingblack.png')),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/wishlistblack.png')),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/profileblack.png')),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
