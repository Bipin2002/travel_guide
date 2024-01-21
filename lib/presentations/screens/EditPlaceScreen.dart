import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_tourist_guide/data/repo/location_repo.dart';

class EditPlaceScreen extends StatefulWidget {
  final Map<String, dynamic> placeData;

  EditPlaceScreen({required this.placeData});

  @override
  _EditPlaceScreenState createState() => _EditPlaceScreenState();
}

class _EditPlaceScreenState extends State<EditPlaceScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController des1Controller = TextEditingController();
  TextEditingController des2Controller = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  XFile? image;
  bool addToPopularDestinations = false;

  @override
  void initState() {
    super.initState();

    // Populate the controllers with existing data
    nameController.text = widget.placeData['name'] ?? '';
    des1Controller.text = widget.placeData['des1'] ?? '';
    des2Controller.text = widget.placeData['des2'] ?? '';
    locationController.text = widget.placeData['location'] ?? '';
    priceController.text = widget.placeData['price'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Place'),
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
                  if (img != null) {
                    setState(() {
                      image = img;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey.shade300,
                  child: Center(
                    child: (image == null)
                        ? (widget.placeData['image'] != null)
                            ? Image.network(widget.placeData['image'],
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover)
                            : Icon(Icons.camera_alt, size: 48)
                        : Image.file(File(image!.path),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover),
                  ),
                ),
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
                decoration: InputDecoration(labelText: 'Per day average cost'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Update the data in Firestore
                  WriteRepo().updatePlace(
                    name: nameController.text,
                    location: locationController.text,
                    des1: des1Controller.text,
                    des2: des2Controller.text,
                    image: widget.placeData['image'] ?? '',
                    price: priceController.text,
                  );

                  // Update the image if it's changed
                  if (image != null) {
                    var aa = File(image!.path);
                    WriteRepo()
                        .storeImage(photo: aa, name: nameController.text);
                  } 

                  Navigator.pop(context);
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
