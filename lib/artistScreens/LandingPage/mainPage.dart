// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/TabScreens/booking/booking.dart';
import 'package:bewtie/TabScreens/chatScreens/inboxScreen.dart';
import 'package:bewtie/TabScreens/exploreScreens/explore.dart';
import 'package:bewtie/TabScreens/profile/account.dart';
import 'package:bewtie/TabScreens/wishlist/wishlist.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/LandingPage/booking/booking.dart';
import 'package:bewtie/artistScreens/LandingPage/inbox/inbox.dart';
import 'package:bewtie/artistScreens/LandingPage/profile/profile.dart';
import 'package:flutter/material.dart';

class ArtistMainPage extends StatefulWidget {
  const ArtistMainPage({super.key});

  @override
  State<ArtistMainPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<ArtistMainPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    InboxScreenArtist(),
    BookingScreenArtist(),
    ArtistProfile()
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
        backgroundColor: Colors.black,
        selectedItemColor: AppColors.primaryPink,
        unselectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/inboxblack.png')),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/bookingblack.png')),
            label: 'Bookings',
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
