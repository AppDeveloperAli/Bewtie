import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/textFieldInput.dart';
import 'package:bewtie/TabScreens/chatScreens/chatScreen.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreenArtist extends StatefulWidget {
  final String uid;
  final String name;
  final String profilePicture;

  const ChatScreenArtist(
      {super.key,
      required this.uid,
      required this.name,
      required this.profilePicture});

  @override
  State<ChatScreenArtist> createState() => _ChatScreenState();
}

// Artist Chat Screen :-

class _ChatScreenState extends State<ChatScreenArtist> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();
  List<String> _users = [];
  List<Message> _messages = [];

  User? _user;
  String _chatroomId = '';

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
        print("--------------------------   $_chatroomId");
      });
    }
    await _createMessagesCollection();
  }

  String get receiverUid => widget.uid;

  Future<void> _createMessagesCollection() async {
    final messagesCollection = _firestore.collection('Messages');
    final userDocument = messagesCollection.doc(_chatroomId);
    if (!(await userDocument.get()).exists) {
      await userDocument.set({});
    }
  }

  void _sendMessage(String messageText, String recieverUid) {
    _firestore.collection('Messages').doc(_chatroomId).collection('chats').add({
      'text': messageText,
      'sender': _auth.currentUser!.uid,
      'receiver': receiverUid,
      'receiverEmail': "",
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Artist Chat Screen");
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
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(""
                  //'Subject (Booking, Date & Time, Location)',
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
                builder: (context, snapshot) {
                  print(snapshot.data.toString());
                  if (snapshot.connectionState == ConnectionState.waiting) {}

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
                              image: NetworkImage(widget.profilePicture),
                              width: 50, // Adjust the width as needed
                              height: 50, // Adjust the height as needed
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(_messages[index].text.toString())),
                          //subtitle: Text(messageList[index].),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // --------------------------------

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
          ],
        ),
      ),
    );
  }
}
