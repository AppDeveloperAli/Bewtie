// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LeaveReviewScreen extends StatefulWidget {
  String postUID;
  LeaveReviewScreen({super.key, required this.postUID});

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                          size: 40,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Leave a review',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Leave a Review...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        maxLines: 20,
                      ),
                    ),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
                onTap: () async {
                  if (auth.currentUser != null && controller.text.isNotEmpty) {
                    uploadReview(controller.text);
                  }
                },
                child: isLoading
                    ? CircularProgressIndicator()
                    : MyCardButton(title: 'Send')),
          )
        ],
      )),
    );
  }

  Future<void> uploadReview(String reviewText) async {
    setState(() {
      isLoading = true;
    });
    String image = '';
    String firstName = '';
    String lastName = '';
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');

      CollectionReference reviews = FirebaseFirestore.instance
          .collection('Post')
          .doc(widget.postUID)
          .collection('PostReviews');

      QuerySnapshot querySnapshot = await users.get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

        if (data != null) {
          image = data['profileimage'] ?? 'N/A';
          firstName = data['first_name'] ?? 'N/A';
          lastName = data['last_name'] ?? 'N/A';
        } else {
          CustomSnackBar(
              context, Text('Data is null for document ID: ${document.id}'));
        }
      }

      await reviews.add({
        'name': '$firstName $lastName',
        'text': reviewText,
        'timestamp': FieldValue.serverTimestamp(),
        'userImage': image,
        'uid': getUid()
      });

      controller.clear();
      Navigator.pop(context);

      CustomSnackBar(context, Text('Review uploaded successfully.'));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      CustomSnackBar(context, Text('Error uploading review: $e'));
    }
  }

  getUid() {
    if (auth.currentUser != null) {
      String uid = auth.currentUser!.uid;
      return uid;
    } else {
      return '';
    }
  }
}
