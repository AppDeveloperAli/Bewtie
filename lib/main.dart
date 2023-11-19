import 'package:bewtie/firebase_options.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        textTheme: TextTheme(bodyMedium: GoogleFonts.manrope()),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
