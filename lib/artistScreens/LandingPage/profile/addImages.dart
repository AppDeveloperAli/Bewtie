import 'dart:io';
import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImagesArtist extends StatefulWidget {
  const AddImagesArtist({Key? key}) : super(key: key);

  @override
  _AddImagesArtistState createState() => _AddImagesArtistState();
}

class _AddImagesArtistState extends State<AddImagesArtist> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<File> selectedImages = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
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
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Add images / videos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Wrap the GridView with SingleChildScrollView
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildImageGrid(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:
                              MyTextCardArtist(title: 'Cancel', fontSize: 18))),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            _uploadImagesAndSaveData();
                          },
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : MyCardButton(title: 'Send'))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    List<Widget> imageWidgets = selectedImages.map((image) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.file(
          image,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      );
    }).toList();

    imageWidgets.add(const ClipRRect());

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: imageWidgets.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == imageWidgets.length - 1) {
            return Stack(
              children: [
                Container(),
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      _pickImages();
                    },
                    child: Card(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        'assets/icons/Add-Image-Icon-White.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return imageWidgets[index];
          }
        },
      ),
    );
  }

  Future<void> _pickImages() async {
    List<XFile>? result = await ImagePicker().pickMultiImage();
    if (result.isNotEmpty) {
      setState(() {
        selectedImages = result.map((xFile) => File(xFile.path)).toList();
      });
    }
  }

  Future<void> _uploadImagesAndSaveData() async {
    setState(() {
      isLoading = true;
    });
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        Reference storageReference =
            _storage.ref().child('post_images/${user.uid}');

        List<String> downloadUrls = [];

        for (File image in selectedImages) {
          String imageName = DateTime.now().millisecondsSinceEpoch.toString();
          UploadTask uploadTask =
              storageReference.child('$imageName.jpg').putFile(image);

          String downloadUrl = await (await uploadTask).ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
        }

        await _firestore.collection('user_data').doc(user.uid).set({
          'images': downloadUrls,
        });

        setState(() {
          isLoading = false;
        });

        CustomSnackBar(context, const Text('Images uploaded successfully!'));
      } catch (error) {
        CustomSnackBar(
            context, Text('Error uploading images and saving data: $error'));
      }
    }
  }
}
