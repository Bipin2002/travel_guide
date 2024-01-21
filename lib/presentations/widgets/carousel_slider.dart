// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  CarouselSliderWidget({
    Key? key,
  }) : super(key: key);

  final CollectionReference ref =
      FirebaseFirestore.instance.collection('carousel');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: ((context, index, realIndex) {
                var ddata = snapshot.data!.docs[index];

                return InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.96,
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(ddata['image']),
                          fit: BoxFit.cover),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 180.0,
                        left: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ddata['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.near_me_sharp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  ddata['location'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
                height: 300,
                viewportFraction: 1,
                autoPlay: true,
                // aspectRatio: 3 / 2,
              ),
            );
          } else {
            return Text('error');
          }
        },
      ),
    );
  }
}
