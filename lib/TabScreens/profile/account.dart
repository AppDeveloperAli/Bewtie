// ignore_for_file: prefer_const_constructors

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardText.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:bewtie/TabScreens/profile/payment.dart';
import 'package:bewtie/TabScreens/profile/personalinfo.dart';
import 'package:bewtie/TabScreens/profile/pinPit.dart';
import 'package:bewtie/TabScreens/profile/termsCondition.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:bewtie/artistScreens/LandingPage/mainPage.dart';
import 'package:bewtie/artistScreens/becomeArtist.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
        child: auth.currentUser != null ? LoggedInView() : MyHomePage(),
      ),
    );
  }
}

class LoggedInView extends StatefulWidget {
  const LoggedInView({super.key});

  @override
  State<LoggedInView> createState() => _LoggedInViewState();
}

class _LoggedInViewState extends State<LoggedInView> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final User? currentUser = FirebaseAuth.instance.currentUser;

  late String firstName = "";
  late String lastName = "";
  late String image = "";

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      getUserData(currentUser!.uid);
    }
  }

  Future<bool> isDocumentExists(
      String collectionName, String documentId) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection(collectionName);

      DocumentSnapshot documentSnapshot =
          await collectionReference.doc(documentId).get();

      return documentSnapshot.exists;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> checkDocument() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String collectionName = 'Artist_Data';
    String documentId = auth.currentUser!.uid;
    return await isDocumentExists(collectionName, documentId);
  }

  Future<void> getUserData(String uid) async {
    try {
      DocumentSnapshot userDoc = await users.doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        setState(() {
          firstName = userData['first_name'] ?? "Name";
          lastName = userData['last_name'] ?? "";
          image = userData['profileimage'] ?? "";
        });
      } else {
        print("User document does not exist");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (context) => LandingPage()),
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
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '$firstName $lastName',
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const LandingPage()));
                      },
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
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () async {
                      if (await checkDocument()) {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const ArtistMainPage()));
                      } else {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const BecomeArtistScreen()));
                      }
                      checkDocument();
                    },
                    child:
                        MyTextCard(title: 'I’m a Betwie Artist', fontSize: 15),
                  ))
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
              Navigator.of(context).push(CupertinoPageRoute(
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
              Navigator.of(context).push(CupertinoPageRoute(
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
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const TermsCondition()));
                },
                child: MyTextCard(title: 'Terms & conditions', fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const TermsCondition()));
                },
                child: MyTextCard(title: 'Privacy Policy', fontSize: 16)),
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
                  auth.signOut().whenComplete(() {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => const LandingPage()));
                  });
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late TextEditingController _phoneNumberController;
  late String? _verificationId;
  String countryTitle = 'Select a Country';
  String phoneCode = '';
  bool isLoading = false;

  bool isOTPsend = false;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _verificationId = null; // Set to null in initState
  }

  Future<void> _verifyPhoneNumber(String numbr) async {
    setState(() {
      isLoading = true;
    });
    await auth.verifyPhoneNumber(
      phoneNumber: numbr,
      timeout: const Duration(minutes: 2),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        void handlePhoneAuthError(
            BuildContext context, FirebaseAuthException e) {
          String errorMessage =
              "An error occurred during phone authentication.";

          switch (e.code) {
            case "invalid-phone-number":
              errorMessage =
                  "The format of the phone number provided is incorrect. Please enter a valid phone number.";
              break;
            case "missing-phone-number":
              errorMessage =
                  "The phone number is missing. Please enter a valid phone number.";
              break;
            case "quota-exceeded":
              errorMessage =
                  "SMS quota for the project has been exceeded. Please try again later.";
              break;
            case "code-expired":
              errorMessage =
                  "The verification code has expired. Please try again.";
              break;
            case "user-disabled":
              errorMessage =
                  "The user associated with the provided phone number has been disabled. Please contact support.";
              break;
            case "too-many-requests":
              errorMessage =
                  "Too many unsuccessful login attempts. Please try again later.";
              break;
            case "session-expired":
              errorMessage =
                  "The verification session has expired. Please initiate the verification process again.";
              break;
            case "invalid-verification-code":
              errorMessage =
                  "The entered verification code is incorrect. Please double-check and try again.";
              break;
            case "invalid-verification-id":
              errorMessage = "Invalid verification ID. Please try again.";
              break;
            case "invalid-credential":
              errorMessage =
                  "Invalid phone authentication credential. Please try again.";
              break;
            // Add more cases for other error codes as needed
            default:
              break;
          }

          CustomSnackBar(context, Text(errorMessage));
          setState(() {
            isLoading = false;
          });
        }

        handlePhoneAuthError(context, e);
      },
      codeSent: (String verificationId, [int? forceResendingToken]) {
        _verificationId = verificationId;
        Navigator.of(context).push(
          CupertinoPageRoute(
              builder: (context) => PinPutScreen(
                    otp: _verificationId,
                    phoneNumber: numbr,
                  )),
        );
        setState(() {
          isLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout, handle it accordingly.
        CustomSnackBar(context, Text('Code request time-out'));
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (context) => LandingPage()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.close,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Log in or Sign up',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
            child: GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  onSelect: (Country country) {
                    setState(() {
                      countryTitle = country.displayName;
                      phoneCode = country.phoneCode;
                      print(countryTitle);
                    });
                  },
                );
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.black),
                ),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  height: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Country / region',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        countryTitle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextInputFeildWidget(
              controller: _phoneNumberController,
              labelText: 'Phone Number',
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () {
                if (_phoneNumberController.text.isNotEmpty) {
                  String phoneNumber =
                      '+$phoneCode${_phoneNumberController.text}';

                  print(phoneNumber);
                  _verifyPhoneNumber(phoneNumber);
                } else {
                  CustomSnackBar(context, Text('Please put the Number...'));
                }
              },
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : MyCardButton(
                      title: 'Continue',
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
