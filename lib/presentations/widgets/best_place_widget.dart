// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_tourist_guide/presentations/pages/individual_pages.dart';

class BestPlaceWidget extends StatelessWidget {
  BestPlaceWidget({
    required this.ref,
    Key? key,
  }) : super(key: key);

  final CollectionReference ref;

  @override
  Widget build(BuildContext context) {
    return Container(
      
   
      height: 200,
      child: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var place = snapshot.data!.docs[index];
                return Container(
                 
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  IndividualPages(aa: place)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 200,
                      margin: EdgeInsets.only(left: 10),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(place['image']),
                                  fit: BoxFit.cover),
                            ),
                          
                          ),
                          Positioned(
                            top: 130,
                            right: 0,
                            left: 20,
                            child: Text(
                              place['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 160,
                            right: 0,
                            left: 20,
                            child: Text(
                              place['location'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Text('error');
          }
        },
      ),
    );
  }
}
