// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_tourist_guide/presentations/pages/individual_pages.dart';
import 'package:smart_tourist_guide/presentations/widgets/best_place_widget.dart';
import 'package:smart_tourist_guide/presentations/widgets/carousel_slider.dart';

String nam = '';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home-screen';
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSliderWidget(),

              //slider

              SizedBox(
                height: 10,
              ),
              //best place
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Popular Destinations',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BestPlaceWidget(
                ref: FirebaseFirestore.instance.collection('popular_des'),
              ),

              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Destinations',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black), // Add bottom border
                  ),
                ),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                height: MediaQuery.of(context).size.height * 0.55,
                width: double.infinity,
                child: StreamBuilder(
                  stream: (nam != '')
                      ? FirebaseFirestore.instance
                          .collection('best_place')
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
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.89),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
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
                            child: Column(
                              children: [
                                Container(
                                  height: 169,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        snapshot.data!.docs[index]['image'],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  snapshot.data!.docs[index]['name'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
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
            ],
          ),
        ),
      ),
    );
  }
}
