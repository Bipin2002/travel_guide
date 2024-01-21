import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocationModel {
  String name;
  String location;
  String image;
  String des1;
  String des2;
  String price;

  
  LocationModel({
    required this.name,
    required this.location,
    required this.image,
    required this.des1,
    required this.des2,
    required this.price,

  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'location': location,
      'image': image,
      'des1': des1,
      'des2': des2,
      'price':price,

    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      name: map['name'] as String,
      location: map['location'] as String,
      image: map['image'] as String,
      des1: map['des1'] as String,
      des2: map['des2'] as String,
      price: map['price'] as String,

    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
