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
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
        selectedLabelStyle: GoogleFonts.manrope(),
        unselectedLabelStyle: GoogleFonts.manrope(),
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                'assets/svg/Inbox-Icon-White.svg',
                height: 25,
                width: 25,
                color:
                    _selectedIndex == 0 ? AppColors.primaryPink : Colors.white,
              ),
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                'assets/svg/Bookings-Icon-White.svg',
                height: 25,
                width: 25,
                color:
                    _selectedIndex == 1 ? AppColors.primaryPink : Colors.white,
              ),
            ),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                'assets/svg/Profile-Icon-White.svg',
                height: 25,
                width: 25,
                color:
                    _selectedIndex == 2 ? AppColors.primaryPink : Colors.white,
              ),
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
