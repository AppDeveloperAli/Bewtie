import 'dart:async';
import 'package:bewtie/landingPage1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const LandingPage(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/S-Splash-Screen-Image.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/images/B Mark.svg',
              fit: BoxFit.fill,
            ),
          )),
    );
  }
}
