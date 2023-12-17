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
                onTap: () {
                  if (auth.currentUser != null) {
                    uploadReview(controller.text);
                  }
                },
                child: MyCardButton(title: 'Send')),
          )
        ],
      )),
    );
  }

  Future<void> uploadReview(String reviewText) async {
    try {
      CollectionReference reviews = FirebaseFirestore.instance
          .collection('Post')
          .doc(widget.postUID)
          .collection('PostReviews');

      await reviews.add({
        'text': reviewText,
        'timestamp': FieldValue.serverTimestamp(),
        'userImage': ""
      });

      CustomSnackBar(context, Text('Review uploaded successfully.'));
    } catch (e) {
      CustomSnackBar(context, Text('Error uploading review: $e'));
    }
  }

  Future<void> retrieveUserData() async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('user');

      QuerySnapshot querySnapshot = await users.get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        String email = data['email'];

        print(' Email: $email');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }
}
