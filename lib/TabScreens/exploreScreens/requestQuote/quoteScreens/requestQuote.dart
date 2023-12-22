// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/quoteScreens/billing.dart';
import 'package:bewtie/TabScreens/exploreScreens/requestQuote/quoteScreens/paymentScreen.dart';
import 'package:bewtie/Utils/colors.dart';
import 'package:bewtie/Utils/snackBar.dart';
import 'package:bewtie/landingPage1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RequestQuoteScreen extends StatefulWidget {
  List<dynamic> mack, hair, nails;
  String? price, name, location, postUid;
  RequestQuoteScreen(
      {super.key,
      required this.hair,
      required this.mack,
      required this.nails,
      required this.price,
      required this.name,
      required this.location,
      required this.postUid});

  @override
  State<RequestQuoteScreen> createState() => _RequestQuoteScreenState();
}

class _RequestQuoteScreenState extends State<RequestQuoteScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String selectedPaymentMethod = '';

  void _onPaymentMethodChanged(String? newPaymentMethod) {
    if (newPaymentMethod != null) {
      setState(() {
        selectedPaymentMethod = newPaymentMethod;
      });
    }
  }

  List<File> selectedImages = [];
  bool isLoading = false;

  String name = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    String first = documentSnapshot['first_name'];
    String last = documentSnapshot['last_name'];

    setState(() {
      name = '$first $last';
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    String hairStatus = isListEmpty(widget.hair) ? '' : 'Hair';
    String makeStatus = isListEmpty(widget.mack) ? '' : 'Makeup';
    String nailsStatus = isListEmpty(widget.nails) ? '' : 'Nails';

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
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Request a quote',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Details',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Services',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Makeup - ${widget.mack.join(', ')}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Hair - ${widget.hair.join(', ')}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Nails - ${widget.nails.join(', ')}',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  formattedDate,
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'How to Pay',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'How would you like to pay',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          selectedPaymentMethod,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () async {
                        final result =
                            await Navigator.of(context).push<String?>(
                          CupertinoPageRoute(
                            builder: (context) => ChangePayment(
                              onPaymentMethodChanged: _onPaymentMethodChanged,
                            ),
                          ),
                        );

                        if (result != null) {
                          _onPaymentMethodChanged(result);
                        }
                        print(result);
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Billing address',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Add a new card for payment',
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const BillingScreen()));
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Price',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Service fee',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 20, top: 20),
                          child: Text(
                            '${convertStringToInteger(widget.price.toString()).toString()} €',
                          )),
                      Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            '0 €',
                          )),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: double.infinity,
                  height: 0.5,
                  color: AppColors.lightPink,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Required for your booking',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Tell Us what you’re after, what time and where you’d like to meet. Be as descriptive as possible, it’ll help our Bewtie Artists with their decision.',
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Start typing',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 10,
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
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Add image',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: _buildImageGrid(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: double.infinity,
                  height: 0.5,
                  color: AppColors.primaryPink,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Cancellation policy',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Free cancellation for 48 hours. Cancel before Nov 12 for a partial refund. Learn more',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: double.infinity,
                  height: 0.5,
                  color: AppColors.primaryPink,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Your reservation won’t be confirmed until our Bewtie Artist accepts your request (within 24 hours). You won’t be charged until then.',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isLoading = true;
                      });

                      Map<String, dynamic> data = {
                        'artname': widget.name,
                        'name': name,
                        'service': '$makeStatus $hairStatus $nailsStatus',
                        'location': widget.location,
                        'price': widget.price,
                        'date': getCurrentDate(),
                        'orderID': '${widget.postUid}_${auth.currentUser!.uid}'
                      };

                      addDataToFirestore(data).whenComplete(() {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const LandingPage()));
                      });

                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : MyCardButton(title: 'Request to book')),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isListEmpty(List<dynamic> list) {
    return list == null || list.isEmpty;
  }

  Future<void> addDataToFirestore(Map<String, dynamic> data) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Orders');

    await collectionReference
        .doc('${auth.currentUser!.uid}_${widget.postUid}')
        .set(data);

    print('Data added to Firestore!');
  }

  int convertStringToInteger(String stringValue) {
    double doubleValue = double.tryParse(stringValue) ?? 0.0;
    int integerValue = doubleValue.toInt();
    return integerValue;
  }

  getCurrentDate() {
    return DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
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
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
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
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        'assets/icons/Add-Image-Icon-Black.png',
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

        await _firestore.collection('Post').doc(user.uid).update({
          'images': downloadUrls,
        });

        setState(() {
          isLoading = false;
        });

        CustomSnackBar(context, const Text('Images uploaded successfully!'));
        Navigator.pop(context);
      } catch (error) {
        CustomSnackBar(
            context, Text('Error uploading images and saving data: $error'));
      }
    }
  }
}
