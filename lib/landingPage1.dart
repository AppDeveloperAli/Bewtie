// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:bewtie/TabScreens/booking/booking.dart';
import 'package:bewtie/TabScreens/chatScreens/inboxScreen.dart';
import 'package:bewtie/TabScreens/exploreScreens/explore.dart';
import 'package:bewtie/TabScreens/profile/account.dart';
import 'package:bewtie/TabScreens/wishlist/wishlist.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
        selectedItemColor: AppColors.primaryPink,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: GoogleFonts.manrope(),
        unselectedLabelStyle: GoogleFonts.manrope(),
        selectedFontSize: 12.0, // Set a specific font size for selected items
        unselectedFontSize: 12.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                'assets/svg/Explore-Icon-Black.svg',
                height: 25,
                width: 25,
                color:
                    _selectedIndex == 0 ? AppColors.primaryPink : Colors.black,
              ),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                'assets/svg/Inbox-Icon-Black.svg',
                height: 25,
                width: 25,
                color:
                    _selectedIndex == 1 ? AppColors.primaryPink : Colors.black,
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
                    _selectedIndex == 2 ? AppColors.primaryPink : Colors.black,
              ),
            ),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                'assets/svg/Wishlist-Icon-Black.svg',
                height: 25,
                width: 25,
                color:
                    _selectedIndex == 3 ? AppColors.primaryPink : Colors.black,
              ),
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset(
                'assets/svg/Profile-Icon-Blacks.svg',
                height: 25,
                width: 25,
                color:
                    _selectedIndex == 4 ? AppColors.primaryPink : Colors.black,
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
