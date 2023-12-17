import 'package:bewtie/Components/cardButton.dart';
import 'package:bewtie/Components/cardSelectionArtist.dart';
import 'package:bewtie/Components/cardTextArtist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AvailibilityArtist extends StatefulWidget {
  const AvailibilityArtist({super.key});

  @override
  State<AvailibilityArtist> createState() => _AvailibilityArtistState();
}

class _AvailibilityArtistState extends State<AvailibilityArtist> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> availability = [];
  List<String> dataList = [];

  @override
  void initState() {
    super.initState();
    loadAvailibilty();
  }

  void loadAvailibilty() async {
    await getListFromFirebase();
    setState(() {});
  }

  Future<List<String>> getListFromFirebase() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('Post').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in querySnapshot.docs) {
        List<dynamic> strings = doc.get('availability');

        if (strings != null && strings is List) {
          for (var value in strings) {
            String stringValue = value.toString();
            if (!dataList.contains(stringValue)) {
              dataList.add(stringValue);
            }
          }
          // if (dataList.contains(strings)) {
          //   print("Already contains");
          // } else {
          //   dataList.addAll(strings.map((value) => value.toString()));
          // }
          //dataList.addAll(strings.map((value) => value.toString()));
        }
      }
    } catch (e) {
      print('Error fetching data from Firebase: $e');
    }

    return dataList;
  }

  Future<void> updateAvailability(String documentId) async {
    CollectionReference artistCollection = _firestore.collection('Post');

    try {
      await artistCollection.doc(documentId).update({
        'availability': availability,
      });

      print('Availability updated successfully!');
    } catch (e) {
      print('Error updating Availability: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(getListFromFirebase().toString());
    print("++++$dataList");
    print("++++${dataList.length}");

    return dataList.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Your availability',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CustomCardArtist(
                      dataList: dataList,
                      title: 'Mon',
                      onTap: () {
                        if (availability.contains("Mon")) {
                          availability.remove("Mon");
                        } else {
                          availability.add("Mon");
                        }
                        setState(() {});
                      },
                    ),
                    CustomCardArtist(
                      dataList: dataList,
                      title: 'Tue',
                      onTap: () {
                        if (availability.contains("Tue")) {
                          availability.remove("Tue");
                        } else {
                          availability.add("Tue");
                        }
                        setState(() {});
                      },
                    ),
                    CustomCardArtist(
                      dataList: dataList,
                      title: 'Wed',
                      onTap: () {
                        if (availability.contains("Wed")) {
                          availability.remove("Wed");
                        } else {
                          availability.add("Wed");
                        }
                        setState(() {});
                      },
                    ),
                    CustomCardArtist(
                      dataList: dataList,
                      title: 'Thu',
                      onTap: () {
                        if (availability.contains("Thu")) {
                          availability.remove("Thu");
                        } else {
                          availability.add("Thu");
                        }
                        setState(() {});
                      },
                    ),
                    CustomCardArtist(
                      dataList: dataList,
                      title: 'Fri',
                      onTap: () {
                        if (availability.contains("Fri")) {
                          availability.remove("Fri");
                        } else {
                          availability.add("Fri");
                        }
                        setState(() {});
                      },
                    ),
                    CustomCardArtist(
                      dataList: dataList,
                      title: 'Sat',
                      onTap: () {
                        if (availability.contains("Sat")) {
                          availability.remove("Sat");
                        } else {
                          availability.add("Sat");
                        }
                        setState(() {});
                      },
                    ),
                    CustomCardArtist(
                      dataList: dataList,
                      title: 'Sun',
                      onTap: () {
                        if (availability.contains("Sun")) {
                          availability.remove("Sun");
                        } else {
                          availability.add("Sun");
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      print("--------$availability");

                      availability.isNotEmpty
                          ? updateAvailability(_auth.currentUser!.uid)
                          : "";
                    },
                    child: Row(
                      children: [
                        Expanded(
                            child: MyTextCardArtist(
                                title: 'Cancel', fontSize: 18)),
                        Expanded(
                            child: MyCardButton(
                          title: 'Save',
                        ))
                      ],
                    ),
                  ),
                )
              ],
            )),
          );
  }
}
