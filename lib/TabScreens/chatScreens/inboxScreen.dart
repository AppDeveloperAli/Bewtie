// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bewtie/TabScreens/chatScreens/chatScreen.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

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
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    fetchDataAndProcess().then((result) {
      setState(() {
        data = result;
        isLoading = false;
      });
    });
    getUID();
    // Timer(Duration(seconds: 7), () {
    //   setState(() {});
    // });
  }

  //

  Future<Map<String, dynamic>> fetchDataAndProcess() async {
    try {
      await getOtherUserUIDs();
      await fetchMessages();
      await getUsersDetails(splittedUIDs);
      await getLastMessages(otherUserUIDs, _auth.currentUser!.uid);

      getUID();

      print('Splitted UIDs: $splittedUIDs');

      // Return a value that you want to use in the builder
      return {
        'usersDetails': usersDetails,
        'userProfilePic': userProfilePic,
        'lastMessages': lastMessages,
      };
    } catch (e) {
      print('Error: $e');
      throw e; // Rethrow the error
    }
  }

  // Split the ChatRoomId to create the receiver UID :-

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

  // To get Name of Chat :-
  List<String> usersDetails = [];
  List<String> userProfilePic = [];

  Future<List<String>> getUsersDetails(List<String> uids) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Artist_Data');

    for (String uid in uids) {
      DocumentSnapshot<Object?>? querySnapshot;
      if (uids.contains(uid)) {
        querySnapshot = await usersCollection
            .doc(uid)
            // Use doc method to directly reference a document by ID
            .get();
      }

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

        print(">>>>>>>>> " + userData.toString());
        //print(userData);
      }
    }

    // Print the entire usersDetails list outside the loop
    print("Users Details: $usersDetails");

    return usersDetails;
  }

  //
  final Map<String, Message> lastMessages = {};

  Future<Map<String, Message>> getLastMessages(
      List<String> chatIds, String currentUserUid) async {
    for (String chatId in chatIds) {
      // Split the chatId to get the second part
      List<String> parts = chatId.split('_');
      String chatUid = parts.length >= 2 ? parts[0] : '';

      // Check if the chatUid matches the currentUserUid
      if (chatUid == currentUserUid) {
        QuerySnapshot<Map<String, dynamic>> chatSnapshot =
            await FirebaseFirestore.instance
                .collection("Messages")
                .doc(chatId)
                .collection("chats")
                .orderBy('timestamp', descending: true)
                .limit(1)
                .get();

        if (chatSnapshot.docs.isNotEmpty) {
          Map<String, dynamic> messageData = chatSnapshot.docs.first.data()!;
          Message lastMessage = Message.fromMap(messageData);
          lastMessages[chatId] = lastMessage;
        } else {
          lastMessages[chatId] = Message(
            text: 'No messages',
            sender: '',
            timestamp: Timestamp.now(),
            receiver: '',
          );
        }
      }
    }

    return lastMessages;
  }

  @override
  Widget build(BuildContext context) {
    getUsersDetails(splittedUIDs);
    getLastMessages(otherUserUIDs, _auth.currentUser!.uid);
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

                  FutureBuilder<Map<String, dynamic>>(
                      future: Future.value(data),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          // Access the result using snapshot.data
                          var data = snapshot.data!;
                          List<String> usersDetails = data['usersDetails'];
                          List<String> userProfilePic = data['userProfilePic'];
                          Map<String, Message> lastMessages =
                              data['lastMessages'];

                          usersDetails.isEmpty
                              ? Timer(
                                  Duration(seconds: 3),
                                  () {
                                    setState(() {});
                                  },
                                )
                              : Container();

                          return Expanded(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: usersDetails.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (context) => ChatScreen(
                                              uid: splittedUIDs[index],
                                              name: usersDetails[index],
                                              profilePicture:
                                                  userProfilePic[index],
                                            ),
                                          ),
                                        );
                                        // When returning from ChatScreen, fetch and update data
                                        fetchDataAndProcess().then((result) {
                                          setState(() {
                                            data = result;
                                            isLoading = false;
                                          });
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: ClipOval(
                                                  child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            userProfilePic[
                                                                index]),
                                                  ),
                                                )),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    //"${usersDetails[index].firstName} ${usersDetails[index].lastName}",
                                                    //splittedUIDs[index],
                                                    usersDetails[index],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text(lastMessages[_auth
                                                                      .currentUser!
                                                                      .uid +
                                                                  "_" +
                                                                  splittedUIDs[
                                                                      index]]
                                                              ?.text
                                                              .toString() ??
                                                          'No messages'
                                                      // lastMessages[
                                                      //               "bkRGIdyFItcXW9oVuK3DoTVxf5K2_bkRGIdyFItcXW9oVuK3DoTVxf5K2"]
                                                      //           ?.text
                                                      //           .toString() ??
                                                      //       'No messages'
                                                      // 'Date last message sent',
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
                          );
                        }

                        //return Center(child: CircularProgressIndicator());
                      }),
                  //),
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

//
class User1 {
  final String uid;
  final String firstName;
  final String lastName;

  User1({required this.uid, required this.firstName, required this.lastName});
}
