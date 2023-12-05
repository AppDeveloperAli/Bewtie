// ignore_for_file: prefer_const_constructors

import 'package:bewtie/TabScreens/chatScreens/chatScreen.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Map<String, String> usersData = {};
  //List<UserModel> userList = [];
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
  }

  //

  Future<void> fetchDataAndProcess() async {
    try {
      await getOtherUserUIDs();

      getUID();
      setState(() {
        isLoading = false;
      });

      print('Splitted UIDs: $splittedUIDs');
    } catch (e) {
      print('Error: $e');
    }
  }

  // Split the ChatRoomId to create the receiver UID :-
  void getUID() {
    for (String inputString in otherUserUIDs) {
      List<String> parts = inputString.split('_');
      List<String> desiredParts = parts.skip(1).toList();

      if (desiredParts.isNotEmpty) {
        String desiredPart = desiredParts.first;
        splittedUIDs.add(desiredPart);
      } else {
        print('Input string does not contain an underscore.');
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

  @override
  Widget build(BuildContext context) {
    //

    print(getOtherUserUIDs());
    print(otherUserUIDs.length);
    print(otherUserUIDs.toString());
    print("--------$desiredParts");
    print('Splitted UIDs: $splittedUIDs');
    print(splittedUIDs.length);

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Inbox',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Messages',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: double.infinity,
                      height: 0.5,
                      color: AppColors.lightPink,
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    //itemCount: splittedUIDs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                        uid: splittedUIDs[index],
                                      )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width:
                                              60, // Adjust the size as needed
                                          height:
                                              60, // Adjust the size as needed
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            width:
                                                15, // Adjust the size as needed
                                            height:
                                                15, // Adjust the size as needed
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.primaryPink,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          splittedUIDs[index],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Date last message sent',
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
                            color: AppColors.lightPink,
                          ),
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

// User Model :-

class UserModel {
  final String name;
  //final String uid;
  //final String lastMessage;

  UserModel({
    required this.name,
    //required this.uid,
    //required this.lastMessage,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['Name'],
      //uid: map['UID'],
      //lastMessage: map['LastMessage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      //'UID': uid,
      //'LastMessage': lastMessage,
    };
  }

  factory UserModel.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      name: snapshot.get('Name'),
      // uid: snapshot.id,
      // lastMessage: snapshot.get('LastMessage'),
    );
  }
}
