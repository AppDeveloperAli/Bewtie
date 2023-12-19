// ignore_for_file: prefer_const_constructors

import 'package:bewtie/TabScreens/chatScreens/chatScreen.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/artistScreens/LandingPage/inbox/chat.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InboxScreenArtist extends StatefulWidget {
  const InboxScreenArtist({super.key});

  @override
  State<InboxScreenArtist> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreenArtist> {
  // Artist Chat Screen :-

//
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> parts = [];
  List<String> desiredParts = [];
  List<String> otherUserUIDs = [];
  List<String> splittedUIDs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataAndProcess();
    getUID();
    fetchMessages();
  }

  //

  Future<void> fetchDataAndProcess() async {
    try {
      await getOtherUserUIDs();

      getUID();
      await fetchMessages();
      setState(() {
        isLoading = false;
      });

      print('Splitted UIDs: $splittedUIDs');
    } catch (e) {
      print('Error: $e');
    }
  }

  // void getUID() {
  //   for (String inputString in otherUserUIDs) {
  //     List<String> parts = inputString.split('_');
  //     List<String> desiredParts = parts.skip(1).toList();

  //     if (desiredParts.isNotEmpty) {
  //       String desiredPart = desiredParts.first;
  //       splittedUIDs.add(desiredPart);
  //     } else {
  //       print('Input string does not contain an underscore.');
  //     }
  //   }
  // }

  //
  void getUID() {
    for (String inputString in otherUserUIDs) {
      List<String> parts = inputString.split('_');

      // Check if there are enough parts and the first part matches the current user's UID
      if (parts.length >= 2 && parts[0] == _auth.currentUser?.uid) {
        String desiredPart = parts[1];
        splittedUIDs.add(desiredPart);
      } else {
        print('Input string does not match the criteria: $inputString');
      }
    }
  }

// Get the ChatRoomIds from the Messages Collection :-
  Future<List<String>> getOtherUserUIDs() async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        return [];
      }

      String currentUserId = currentUser.uid;

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('Messages')
          .where(FieldPath.documentId, isNotEqualTo: currentUserId)
          .get();

      querySnapshot.docs.addAll(await _firestore
          .collection('Messages')
          .where(FieldPath.documentId, isEqualTo: currentUserId)
          .get()
          .then((value) => value.docs));

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in querySnapshot.docs) {
        otherUserUIDs.add(doc.id);
      }

      otherUserUIDs = otherUserUIDs.toSet().toList();

      return otherUserUIDs;
    } catch (e) {
      print('Error fetching other user UIDs: $e');
      return [];
    }
  }

//
// Artist Inbox Screen :-
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> messageIds = [];

  Future<List<String>> fetchMessages() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? currentUser = auth.currentUser;

      if (currentUser == null) {
        // Handle the case where the user is not logged in
        return [];
      }

      String currentUserId = currentUser.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('Messages')
          .where(FieldPath.documentId,
              isGreaterThanOrEqualTo: '$currentUserId\0')
          .where(FieldPath.documentId, isLessThan: '$currentUserId\1')
          .get();

      print("==============${querySnapshot.toString()}");

      messageIds = querySnapshot.docs.map((doc) {
        return doc.id;
      }).toList();

      return messageIds;
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }

//
  // To get Name of Chat :-
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');
  //    List<String> usersDetails = [];

  // Future<List<String>> getUsersDetails(List<String> uids) async {
  //   for (String uid in uids) {
  //     QuerySnapshot querySnapshot = await usersCollection
  //         .where(FieldPath.documentId, isEqualTo: uid)
  //         .get();

  //     print("========${querySnapshot.toString()}");

  //     if (querySnapshot.docs.isNotEmpty) {
  //       Map<String, dynamic> userData =
  //           querySnapshot.docs.first.data() as Map<String, dynamic>;
  //       String firstName = userData['first_name'] ?? '';
  //       String lastName = userData['last_name'] ?? '';

  //       // print("======${userData.toString()}");

  //       usersDetails = querySnapshot.docs
  //           .map((doc) => '${doc['first_name']} ${doc['last_name']}')
  //           .toList();

  //       //print("=======${usersDetails[1].firstName + " " + lastName}");
  //     }
  //   }

  //   return usersDetails;
  // }
  //
  List<String> usersDetails = [];
  List<String> userProfilePic = [];

  Future<List<String>> getUsersDetails(List<String> uids) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');

    for (String uid in uids) {
      DocumentSnapshot<Object?>? querySnapshot;
      if (uids.contains(uid)) {
        querySnapshot = await usersCollection
            .doc(uid)
            // Use doc method to directly reference a document by ID
            .get();
      }

      // DocumentSnapshot<Object?> querySnapshot = await usersCollection
      //     .doc(uid) // Use doc method to directly reference a document by ID
      //     .get();

      if (querySnapshot!.exists) {
        Map<String, dynamic> userData =
            querySnapshot.data()! as Map<String, dynamic>;
        String firstName = userData['first_name'] ?? '';
        String lastName = userData['last_name'] ?? '';
        String profileUrl = userData['profileimage'] ?? '';

        String fullName = '$firstName $lastName';
        if (usersDetails.contains(fullName)) {
          print("");
        } else {
          usersDetails.add(fullName);
          userProfilePic.add(profileUrl);
        }
        // usersDetails.add(fullName);
      }

      if (querySnapshot.exists) {
        Object userData = querySnapshot.data()!;
        // String firstName = userData['first_name'] ?? '';
        // String lastName = userData['last_name'] ?? '';

        // String fullName = '$firstName $lastName';
        //usersDetails.add(fullName);

        print(">>>>>>>>> " + userData.toString());
        //print(userData);
      }
    }

    // Print the entire usersDetails list outside the loop
    print("Users Details: $usersDetails");

    return usersDetails;
  }

  @override
  Widget build(BuildContext context) {
    print("==========");
    print("===============${fetchMessages().toString()}");
    print("==================$messageIds");
    print("+++++++++++");
    print(getOtherUserUIDs());
    print('Splitted UIDs: $splittedUIDs');
    print(splittedUIDs.length);
    print("---------${usersDetails.length}");
    print(getUsersDetails(splittedUIDs));
    // print("+++++++++${usersDetails.toString()}");
    // print("+++++++++${usersDetails.length}");
    // print(">>>>>>>>>>>$userProfilePic");
    // print(">>>>>>>>>>${fetchMessages()}");
    // print(">>>>>>>>>>>$messageIds");

    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LandingPage()),
                        (route) => false,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Inbox',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Messages',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.white),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: usersDetails.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatScreenArtist(
                                        uid: splittedUIDs[index],
                                      )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                        radius: 30,
                                        child: ClipOval(
                                            child: Image.network(
                                                userProfilePic[index])),
                                      )),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          //'Name',
                                          //splittedUIDs[index],
                                          "${usersDetails[index]}",

                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Manrope',
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Date last message sent',
                                          style: TextStyle(
                                              fontFamily: 'Manrope',
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              height: 0.5,
                              color: Colors.white),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}


// Stack(
//                                 children: [
//                                   Container(
//                                     width: 60, // Adjust the size as needed
//                                     height: 60, // Adjust the size as needed
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Colors.grey[300],
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 0,
//                                     right: 0,
//                                     child: Container(
//                                       width: 15, // Adjust the size as needed
//                                       height: 15, // Adjust the size as needed
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: AppColors.primaryPink,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),