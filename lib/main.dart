import 'package:bewtie/landingPage1.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bewtie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryPink),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
