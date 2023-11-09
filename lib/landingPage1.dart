// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/TabScreens/booking/booking.dart';
import 'package:bewtie/TabScreens/chatScreens/inboxScreen.dart';
import 'package:bewtie/TabScreens/exploreScreens/explore.dart';
import 'package:bewtie/TabScreens/profile/account.dart';
import 'package:bewtie/TabScreens/wishlist/wishlist.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ExploreScreen(),
    InboxScreen(),
    BookingScreen(),
    WishlistScreen(),
    AccountScreen()
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
        selectedItemColor: AppColors.primaryPink, // Color for the selected item
        unselectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/Explore-Icon-Black.svg',
              width: 30,
              color: _selectedIndex == 0 ? AppColors.primaryPink : Colors.black,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/Inbox-Icon-Black.svg',
              width: 25,
              color: _selectedIndex == 1 ? AppColors.primaryPink : Colors.black,
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/Bookings-Icon-Black.svg',
              width: 18,
              color: _selectedIndex == 2 ? AppColors.primaryPink : Colors.black,
            ),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/Wishlist-Icon-Black.svg',
              width: 25,
              color: _selectedIndex == 3 ? AppColors.primaryPink : Colors.black,
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/Profile-Icon-Black.svg',
              width: 25,
              color: _selectedIndex == 4 ? AppColors.primaryPink : Colors.black,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
