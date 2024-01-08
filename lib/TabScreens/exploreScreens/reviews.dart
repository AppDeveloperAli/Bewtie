// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bewtie/Utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewsScreen extends StatefulWidget {
  String postUid;
  ReviewsScreen({super.key, required this.postUid});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  Future<Map<String, dynamic>> fetchUserData(String uid) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    return userSnapshot.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
                padding: const EdgeInsets.all(10),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Post')
                        .doc(widget.postUid)
                        .collection('PostReviews')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      var data = snapshot.data!.docs;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${data.length} Reviews',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var review = data[index];
                              Timestamp timestamp = data[index]['timestamp'];
                              DateTime dateTime = timestamp.toDate();
                              String formattedDate =
                                  DateFormat('yyyy/MM/dd - HH:mm:ss')
                                      .format(dateTime);

                              return FutureBuilder(
                                future: fetchUserData(review['uid']),
                                builder: (context, userSnapshot) {
                                  if (userSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }

                                  var userData = userSnapshot.data ?? {};

                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: NetworkImage(
                                              userData['profileimage'] ??
                                                  'https://img.freepik.com/free-icon/user_318-563642.jpg?w=2000',
                                            ),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            userData['first_name'] != null &&
                                                    userData['last_name'] !=
                                                        null
                                                ? '${userData['first_name']} ${userData['last_name']}'
                                                : 'Bewtiebook User',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            formattedDate,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Text(
                                            review['text'],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
