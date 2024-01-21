import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:smart_tourist_guide/data/model/location_model.dart';
import 'package:smart_tourist_guide/data/model/user_info.dart';

FirebaseFirestore storage = FirebaseFirestore.instance;

class WriteRepo {
  FirebaseFirestore storage = FirebaseFirestore.instance;
  Future best_place(
      {required String name,
      required String location,
      required String des1,
      required String des2,
      required String image,
      required String price}) async {
    var info = storage.collection('best_place').doc(name);

    info.set(LocationModel(
      name: name,
      location: location,
      image: image,
      des1: des1,
      des2: des2,
      price: price,
    ).toMap());
  }

  Future popular_des(
      {required String name,
      required String location,
      required String des1,
      required String des2,
      required String image,
      required String price}) async {
    var info = storage.collection('popular_des').doc(name);

    info.set(LocationModel(
            name: name,
            location: location,
            image: image,
            price: price,
            des1: des1,
            des2: des2)
        .toMap());
  }

  Future storeImage({
    required File photo,
    required String name,
  }) async {
    try {
      UploadTask? uploadTask;
      var ref = FirebaseStorage.instance.ref().child('best_place').child(name);
      ref.putFile(photo);
      var ref1 = FirebaseStorage.instance.ref().child('popular_des').child(name);
      ref1.putFile(photo);
      uploadTask = ref.putFile(photo);
      final snap = await uploadTask.whenComplete(() {});
      final urls = await snap.ref.getDownloadURL();
      var user = storage.collection('best_place').doc(name);
      var user1 = storage.collection('popular_des').doc(name);
      await user.update({'image': urls});
      await user1.update({'image': urls});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updatePlace({
    required String name,
    String? location,
    String? des1,
    String? des2,
    String? image,
    String? price,
  }) async {
    try {
      final CollectionReference collection =
          FirebaseFirestore.instance.collection('best_place');

      final QuerySnapshot querySnapshot =
          await collection.where('name', isEqualTo: name).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Iterate through documents (though there should be only one)
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          final String documentId = doc.reference.id;

          await collection.doc(documentId).update({
            'location': location ?? '',
            'des1': des1 ?? '',
            'des2': des2 ?? '',
            'image': image ?? '',
            'price': price ?? '',
          });
        }
      } else {
        // Handle case where no matching document is found
        print('No matching document found for name: $name');
      }
    } catch (error) {
      // Handle error, such as showing a snackbar or logging
      print('Error updating place: $error');
    }
  }

 
  Future userinfo({required String name, required String email}) async {
    var useri = storage.collection('userinfo').doc(name);
    useri.set(UserInfo(name: name, email: email, role: 'user').toMap());
  }
}
