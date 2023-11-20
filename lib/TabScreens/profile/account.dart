// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:bewtie/TabScreens/profile/payment.dart';
import 'package:bewtie/TabScreens/profile/personalinfo.dart';
import 'package:bewtie/TabScreens/profile/termsCondition.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      body: SafeArea(
        child: auth.currentUser != null
            ? logged_in_View(context)
            : Logged_Out_view(),
      ),
    );
  }

  Widget logged_in_View(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.close,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 60, // Adjust the size as needed
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: AppColors.lightPink,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Switch accounts',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                        color: AppColors.primaryPink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Center(
                              child: Text('I need an Artist',
                                  style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15))),
                        )),
                  ),
                  Expanded(
                      child: MyTextCard(
                          title: 'I’m a Betwie Artist', fontSize: 15))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: AppColors.lightPink,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PersonalInformation()));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Personal information'),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: AppColors.lightPink,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PaymentsScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text('Payments'), Icon(Icons.arrow_forward)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: AppColors.lightPink,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Legal',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TermsCondition()));
                },
                child: MyTextCard(title: 'Terms & conditions', fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: MyTextCard(title: 'Privacy Policy', fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: AppColors.primaryPink,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20,
            ),
            child: GestureDetector(
                onTap: () {
                  auth.signOut();
                },
                child: MyCardButton(title: 'Log out')),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: AppColors.primaryPink,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
            child: MyTextCard(title: 'Delete Account', fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class Logged_Out_view extends StatefulWidget {
  const Logged_Out_view({super.key});

  @override
  State<Logged_Out_view> createState() => _Logged_Out_viewState();
}

class _Logged_Out_viewState extends State<Logged_Out_view> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController1 = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController emailController2 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextInputFeildWidget(
            labelText: "Email",
            controller: emailController1,
          ),
          TextInputFeildWidget(
            labelText: "Password",
            controller: passwordController1,
          ),
          GestureDetector(
              onTap: () {
                auth.createUserWithEmailAndPassword(
                    email: emailController1.text,
                    password: passwordController1.text);
              },
              child: MyCardButton(title: "Sign Up")),
          SizedBox(
            height: 25,
          ),
          TextInputFeildWidget(
            labelText: "Email",
            controller: emailController2,
          ),
          TextInputFeildWidget(
            labelText: "Password",
            controller: passwordController2,
          ),
          GestureDetector(
              onTap: () {
                auth.signInWithEmailAndPassword(
                    email: emailController2.text,
                    password: passwordController2.text);
              },
              child: MyCardButton(title: "Sign In")),
        ],
      ),
    );
  }
}

// class Logged_Out_view extends StatefulWidget {
//   const Logged_Out_view({super.key});

//   @override
//   State<Logged_Out_view> createState() => _Logged_Out_viewState();
// }

// class _Logged_Out_viewState extends State<Logged_Out_view> {
//   String countryTitle = 'United Kingdom';

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: () {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(builder: (context) => LandingPage()),
//             );
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Icon(
//               Icons.close,
//               size: 40,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Text(
//             'Log in or Sign up',
//             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
//           child: GestureDetector(
//             onTap: () {
//               showCountryPicker(
//                 context: context,
//                 showPhoneCode: true,
//                 onSelect: (Country country) {
//                   setState(() {
//                     countryTitle = '${country.displayName}';
//                     print(countryTitle);
//                   });
//                 },
//               );
//             },
//             child: Card(
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//                 side: BorderSide(color: Colors.black),
//               ),
//               child: Container(
//                 padding: EdgeInsets.all(10.0),
//                 width: double.infinity,
//                 height: 80.0,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Country / region',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       countryTitle,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 15, left: 15),
//           child: TextInputFeildWidget(
//             labelText: 'Phone Number',
//             keyboardType: TextInputType.number,
//           ),
//         )
//       ],
//     );
//   }
// }
