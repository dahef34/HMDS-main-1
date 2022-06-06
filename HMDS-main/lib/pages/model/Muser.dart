import 'package:cloud_firestore/cloud_firestore.dart';

class Muser {
  String? uid;
  String? email;
  String? name;
  String? nric;
  String? post;
  String? dept;
  String? hosp;
  String? street;
  String? city;
  String? postcode;
  String? state;
  String? country;

  Muser(
      {this.uid,
      this.email,
      this.name,
      this.nric,
      this.post,
      this.dept,
      this.hosp,
      this.street,
      this.city,
      this.postcode,
      this.state,
      this.country});

  factory Muser.fromMap(map) {
    return Muser(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      nric: map['nric'],
      post: map['post'],
      dept: map['dept'],
      hosp: map['hosp'],
      street: map['street'],
      city: map['city'],
      postcode: map['postcode'],
      state: map['state'],
      country: map['country'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'nric': nric,
      'post': post,
      'dept': dept,
      'hosp': hosp,
      'street': street,
      'city': city,
      'postcode': postcode,
      'state': state,
      'country': country,
    };
  }
}
