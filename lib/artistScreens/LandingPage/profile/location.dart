import 'dart:convert';

import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardSelectionArtist.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:bewtie/Components/textFieldArtist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class LocationArtist extends StatefulWidget {
  const LocationArtist({super.key});

  @override
  State<LocationArtist> createState() => _LocationArtistState();
}

class _LocationArtistState extends State<LocationArtist> {
  var _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyDjY2FhuQ9P8QYBNoRBYIha0dLLRJnohDg";

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      // toastMessage('success');
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _locationController = TextEditingController();

  Future<void> updateLocation(String documentId) async {
    CollectionReference artistCollection = _firestore.collection('Post');

    try {
      await artistCollection.doc(documentId).update({
        'Location': _locationController.text,
      });

      print('Location updated successfully!');
    } catch (e) {
      print('Error updating Location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Your location',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              TextInputFeildWidgetArtist(
                labelText: 'Enter your location',
                controller: _controller,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {},
                    child: ListTile(
                      title: Text(_placeList[index]["description"]),
                    ),
                  );
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                print("-------$_locationController");
                _locationController.text != ""
                    ? updateLocation(_auth.currentUser!.uid)
                    : "";
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Expanded(
                      child: MyTextCardArtist(title: 'Cancel', fontSize: 18)),
                  Expanded(child: MyCardButton(title: 'Save'))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
