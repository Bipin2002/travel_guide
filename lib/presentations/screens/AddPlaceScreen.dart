import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_tourist_guide/data/repo/location_repo.dart';

class AddPlaceScreen extends StatefulWidget {
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController des1Controller = TextEditingController();
  TextEditingController des2Controller = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  XFile? image;
  bool addToPopularDestinations = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final img =
                      await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    image = img;
                  });
                },
                child: image == null
                    ? Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey.shade300,
                        child: Center(
                          child: Icon(Icons.camera_alt, size: 48),
                        ),
                      )
                    : Image.file(File(image!.path),
                        height: 200, width: double.infinity, fit: BoxFit.cover),
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: des1Controller,
                decoration: InputDecoration(labelText: 'Description Line 1'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: des2Controller,
                decoration: InputDecoration(labelText: 'Description Line 2'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Per day avergae cost'),
              ),
              Row(
                children: [
                  Checkbox(
                    value: addToPopularDestinations,
                    onChanged: (value) {
                      setState(() {
                        addToPopularDestinations = value ?? false;
                      });
                    },
                  ),
                  Text('Add to Popular Destinations'),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  WriteRepo().best_place(
                      name: nameController.text,
                      location: locationController.text,
                      des1: des1Controller.text,
                      des2: des2Controller.text,
                      image: "",
                      price: priceController.text);
                  if (addToPopularDestinations) {
                    WriteRepo().popular_des(
                      name: nameController.text,
                      location: locationController.text,
                      des1: des1Controller.text,
                      des2: des2Controller.text,
                      image: "",
                      price: priceController.text,
                    );
                  }
                  var aa = File(image!.path);
                  WriteRepo().storeImage(photo: aa, name: nameController.text);
                  Navigator.pop(context);
                },
                child: Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
