// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_tourist_guide/presentations/pages/individual_pages.dart';
import 'package:smart_tourist_guide/presentations/screens/AddPlaceScreen.dart';
import 'package:smart_tourist_guide/presentations/screens/EditPlaceScreen.dart';
import 'package:smart_tourist_guide/presentations/screens/main_screen.dart';

class DiscoverScreen extends StatefulWidget {
  static const String routeName = 'add_place';
  DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  TextEditingController search = TextEditingController();

  String nam = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainScreen.routeName);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        title: Text(
          'Add Place',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.82,
                width: 400,
                child: StreamBuilder(
                  stream: (nam != '')
                      ? FirebaseFirestore.instance
                          .collection('best_place')
                          .where(nam)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('best_place')
                          .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      var filter = snapshot.data?.docs.where((element) =>
                          element["name"]
                              .toString()
                              .toLowerCase()
                              .contains(nam.toString().toLowerCase()));
                      return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          var placeData = filter?.elementAt(index).data()
                              as Map<String, dynamic>;
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IndividualPages(
                                    aa: snapshot.data!.docs[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              snapshot.data!.docs[index]
                                                  ['image'],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        margin: EdgeInsets.all(10),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['name'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  // Second Column (Edit and Delete Buttons)

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Implement edit functionality
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPlaceScreen(
                                                placeData: placeData,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          fixedSize: Size(100, 40),
                                        ),
                                        child: Text('Edit'),
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () async {
                                          bool deleteConfirmed =
                                              (await showDeleteConfirmationDialog(
                                                      context)) ??
                                                  false;

                                          if (deleteConfirmed) {
                                            // Delete the Firestore document
                                            await FirebaseFirestore.instance
                                                .collection('best_place')
                                                .doc(
                                                    filter?.elementAt(index).id)
                                                .delete();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          fixedSize: Size(100, 40),
                                        ),
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Text('aa');
                    }
                  },
                ),
              ),
              SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPlaceScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

Future<bool?> showDeleteConfirmationDialog(BuildContext context) async {
  return await showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirm Deletion"),
        content: Text("Are you sure you want to delete this place?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel the delete operation
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Confirm the delete operation
            },
            child: Text("Delete"),
          ),
        ],
      );
    },
  );
}
