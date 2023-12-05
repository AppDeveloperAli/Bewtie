import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String uid;
  const ChatScreen({super.key, required this.uid});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final String receiverUid = '';
  final TextEditingController _messageController = TextEditingController();
  List<String> _users = [];
  List<Message> _messages = []; // List to store chat messages

  User? _user;
  String _chatroomId = '';
  //User get user => _auth.currentUser!;

  @override
  void initState() {
    super.initState();
    //_user = _auth.currentUser!;
    _getUser();
    //_fetchMessages("siHs9q6iCLaAeJIdPFnwn5hTrI22");
  }

  void _getUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
        _chatroomId = '${_user!.uid}_${receiverUid}';
        // _chatroomId = widget.uid;
        print("--------------------------   $_chatroomId");
        //_chatroomId = _user!.uid;
      });
    }
    await _createMessagesCollection();
  }

  String get receiverUid => widget.uid;

  Future<void> _createMessagesCollection() async {
    final messagesCollection = _firestore.collection('Messages');
    final userDocument = messagesCollection.doc(_chatroomId);
    if (!(await userDocument.get()).exists) {
      // 'Messages' collection or the user's document doesn't exist, create them
      await userDocument.set({});
    }
  }

  void _sendMessage(String messageText, String recieverUid) async {
    await _firestore
        .collection('Messages')
        .doc(_chatroomId)
        .collection('chats')
        .add({
      'text': messageText,
      'sender': _auth.currentUser!.uid,
      'receiver': receiverUid,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get Messages :-

  // Stream<QuerySnapshot> getAllMsg(String userId, String receiverUid) {
  //   User? _user = _auth.currentUser;
  //   _chatroomId = '${_user!.uid}_${receiverUid}';
  //   return _firestore
  //       .collection('Messages')
  //       .doc(_chatroomId)
  //       //.doc("8ln9IPy7tvxOhT8JkRBb*8pGIQx0dCtOGQxqSr1qz0QxnKo72")
  //       .collection('chats')
  //       .orderBy("timestamp")
  //       .snapshots();
  // }

  // void _fetchMessages(String receiverUid) {
  //   _firestore
  //       .collection('Messages')
  //       .doc("0Bsc6DbKL9Ya94a5ToBAsJJ2Iiy1_Mex5GJGGgGY1zfMhfccU")
  //       .collection('chats')
  //       .orderBy('timestamp')
  //       .snapshots()
  //       .listen((snapshot) {
  //     var messages = snapshot.docs
  //         .map((doc) => Message.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList();

  //     setState(() {
  //       _messages = messages;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print("----------${widget.uid}");
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (context) {
                            return Container(
                              width: double.infinity,
                              height: 400,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryPink,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const Center(
                                        child: Text(
                                      'We take all reports seriously,  therefor we will be in touch via email soon,  to find out more about your issue.',
                                      textAlign: TextAlign.center,
                                    )),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: MyCardButton(
                                            title: 'Report this person'))
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Icon(
                      Icons.more_horiz_rounded,
                      color: AppColors.primaryPink,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Subject (Booking, Date & Time, Location)',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: double.infinity,
                height: 0.5,
                color: AppColors.lightPink,
              ),
            ),

            Expanded(
              child: StreamBuilder(
                stream: _firestore
                    .collection("Messages")
                    .doc("${_auth.currentUser!.uid}_$receiverUid")
                    .collection("chats")
                    .orderBy("timestamp")
                    .snapshots(),

                // FirebaseFirestore.instance
                //     .collection('Messages')
                //     .doc(_chatroomId)
                //     .collection('chats')
                //     .orderBy("timestamp")
                //     .snapshots(),

                //
                //stream: _fireStoreServices.loadMessages(widget.chatUser),
                // stream: getAllMsg(_user!.uid, receiverUid),

                builder: (context, snapshot) {
                  print(snapshot.data.toString());
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // print("===============${user.uid.toString()}");
                    // print("===============${widget.chatUser.id}");
                    // print("===============${user.displayName.toString()}");
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text('No messages available.'));
                  }

                  print(snapshot.data.toString());

                  final data = snapshot.data!.docs;

                  _messages = data
                      .map((e) =>
                          Message.fromMap(e.data() as Map<String, dynamic>))
                      .toList();

                  print(_messages.length);
                  //messageList = snapshot.data!.docs;
//
                  // print("---------------------- $messageList");

                  if (_messages.isEmpty) {
                    return const Center(child: Text('No messages'));
                  }

                  return ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                          leading: ClipOval(
                            child: Image(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1580273916550-e323be2ae537?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8bHV4dXJ5JTIwY2FyfGVufDB8fDB8fHww")),
                          ),
                          title: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(_messages[index].text.toString())),
                          subtitle: Text(
                              _messages[index].timestamp.toDate().toString()),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // --------------------------------
            // Expanded(
            //   child: ListView.builder(
            //     physics: const NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemCount: 3,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(15.0),
            //             child: Row(
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.all(10.0),
            //                   child: Container(
            //                     width: 60, // Adjust the size as needed
            //                     height: 60, // Adjust the size as needed
            //                     decoration: BoxDecoration(
            //                       shape: BoxShape.circle,
            //                       color: Colors.grey[300],
            //                     ),
            //                   ),
            //                 ),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Row(
            //                       children: [
            //                         Padding(
            //                           padding: const EdgeInsets.only(left: 10),
            //                           child: Text(
            //                             _messages[1].text,

            //                             //"Name",
            //                             style: const TextStyle(
            //                                 fontWeight: FontWeight.bold,
            //                                 fontFamily: 'Manrope'),
            //                           ),
            //                         ),
            //                         const Padding(
            //                           padding: EdgeInsets.only(left: 10),
            //                           child: Text(
            //                             'X:XX AM',
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     const Padding(
            //                       padding: EdgeInsets.only(left: 10),
            //                       child: Text(
            //                         'Xxxxxxxxxx',
            //                         style: TextStyle(fontFamily: 'Manrope'),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 100.0),
            //             child: Container(
            //               width: double.infinity,
            //               height: 0.5,
            //               color: AppColors.lightPink,
            //             ),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextInputFeildWidget(
                    labelText: "Enter Message",
                    controller: _messageController,
                  )),
                  IconButton(
                    onPressed: () {
                      // _sendMessage(_messageController.text);

                      if (_messageController.text.isNotEmpty) {
                        _sendMessage(_messageController.text, receiverUid);
                        _messageController.clear();
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: TextInputFeildWidget(
            //     labelText: 'Type a message',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// Message Model :-
class Message {
  final String text;
  final String sender;
  final String receiver;
  final Timestamp timestamp;

  Message({
    required this.text,
    required this.sender,
    required this.receiver,
    required this.timestamp,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] ?? '',
      sender: map['sender'] ?? '',
      receiver: map['receiver'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }
}
