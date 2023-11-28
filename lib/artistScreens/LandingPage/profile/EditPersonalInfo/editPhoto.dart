// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:bewtie/Components/cardButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class EditPhotoArtist extends StatefulWidget {
  const EditPhotoArtist({super.key});

  @override
  State<EditPhotoArtist> createState() => _EditPhotoState();
}

class _EditPhotoState extends State<EditPhotoArtist> {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirestoreService _firestoreService = FirestoreService();

  File? _pickedImage;
  bool _uploading = false;

  Future<void> _uploadImage() async {
    setState(() {
      _uploading = true;
    });

    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });

      String imageUrl = await _storageService.uploadImage(_pickedImage!);
      await _firestoreService.uploadImage(imageUrl);

      setState(() {
        _uploading = false;
      });

      Navigator.pop(context);
    } else {
      setState(() {
        _uploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Change your profile photo',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          child: _pickedImage != null
                              ? ClipOval(
                                  child: Image.file(
                                    _pickedImage!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child: Text('No Image Selected'),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: GestureDetector(
                          onTap: () {
                            _uploadImage();
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: 'Manrope',
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () async {
                  _uploadImage();
                },
                child: MyCardButton(
                  title: _uploading ? 'Uploading...' : 'Done',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile) async {
    String fileName = path.basename(imageFile.path);
    Reference storageReference =
        _storage.ref().child('profile_picture/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}

class FirestoreService {
  Future<void> uploadImage(String imageUrl) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user != null) {
      String currentUserId = user.uid;

      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('Artist');

      final DocumentReference userDocument = userCollection.doc(currentUserId);

      final CollectionReference profileCollection =
          userDocument.collection('Profile_Data');

      await profileCollection
          .doc(_auth.currentUser!.uid)
          .set({'profileimage': imageUrl});
    } else {}
  }
}
