import 'dart:math';

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinPutScreen extends StatefulWidget {
  String? phoneNumber;
  String? otp;
  PinPutScreen({super.key, required this.phoneNumber, required this.otp});

  @override
  State<PinPutScreen> createState() => _PinPutScreenState();
}

class _PinPutScreenState extends State<PinPutScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/S-Log-3-Image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15, right: 15, left: 15),
              child: Text(
                'Confirm your number',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Enter the code we sent over SMS to ${widget.phoneNumber}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Container(
                width: double.infinity,
                height: 100,
                child: Pinput(
                  length: 6,
                  // validator: (s) {
                  //   if () {
                  //     _signInWithPhoneNumber(s.toString());
                  //     return null;
                  //   } else {
                  //     return 'Pin is incorrect';
                  //   }
                  // },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => _signInWithPhoneNumber(pin),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: MyCardButton(title: 'Continue'),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> _signInWithPhoneNumber(String code) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.otp!,
        smsCode: code,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (auth.currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        CustomSnackBar(
            context,
            Text(
                'Incorrect Code - Please put the correct code for varification'));
      } else {
        CustomSnackBar(context, Text('Something went wrong with number'));
      }
    } catch (e) {
      CustomSnackBar(context, Text('Something went wrong'));
    }
  }
}
