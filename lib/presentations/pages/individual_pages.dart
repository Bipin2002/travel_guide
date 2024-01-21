// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_tourist_guide/data/model/place_model.dart';
import 'package:smart_tourist_guide/presentations/screens/main_screen.dart';

class IndividualPages extends StatefulWidget {
  static const String routeName = 'individualpage';
  IndividualPages({Key? key, required this.aa}) : super(key: key);

  final QueryDocumentSnapshot<Object?> aa;

  @override
  _IndividualPagesState createState() => _IndividualPagesState();
}

class _IndividualPagesState extends State<IndividualPages> {
  int personCount = 1; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1.2,
            child: Stack(
              children: [
                ImageContainer(aa: widget.aa),
                detailsContainer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned detailsContainer(BuildContext context) {
    int basePrice = int.parse(widget.aa['price']);

    return Positioned(
      top: 300,
      right: 0,
      left: 0,
      child: Container(
        height: 750,
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.aa['name'],
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.aa['des1'],
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.aa['des2'],
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 20,
            ),
             Text(
              'Per day',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'average cost for $personCount person(s): Rs.${basePrice * personCount}',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    
                    setState(() {
                      if (personCount > 1) {
                        personCount--;
                      }
                    });
                  },
                  child: Text(' - '),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Increase person count and update UI
                    setState(() {
                      personCount++;
                    });
                  },
                  child: Text(' + '),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    Key? key,
    required this.aa,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> aa;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    var place = [
      Places(
        photourl: widget.aa['image'],
        location: widget.aa['location'],
        des1: widget.aa['des1'],
        des2: widget.aa['des2'],
        name: widget.aa['name'],
      )
    ];
    return Container(
      height: 350,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.aa['image']),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, MainScreen.routeName);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 40,
              minWidth: 20,
              color: Colors.white,
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
