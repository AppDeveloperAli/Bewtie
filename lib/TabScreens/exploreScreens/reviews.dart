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
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }

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

                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CircleAvatar(
                                          radius: 30.0,
                                          backgroundImage: NetworkImage(review[
                                                      'userImage'] ==
                                                  'N/A'
                                              ? 'https://img.freepik.com/free-icon/user_318-563642.jpg?w=2000'
                                              : review['userImage']),
                                          backgroundColor: Colors.transparent,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        review['name'] != 'N/A'
                                            ? review['name']
                                            : 'Bewtiebook User',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
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
