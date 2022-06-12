import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String? uid;
  String? title;
  String? details;
  String? muser;
  String? puser;
  String? day;
  String? month;
  String? year;
  String? hour;
  String? min;

  Appointment(
      {this.uid,
      this.title,
      this.details,
      this.muser,
      this.puser,
      this.day,
      this.month,
      this.year,
      this.hour,
      this.min});

  factory Appointment.fromMap(map) {
    return Appointment(
      uid: map['uid'],
      title: map['title'],
      details: map['details'],
      muser: map['muser'],
      puser: map['puser'],
      day: map['day'],
      month: map['month'],
      year: map['year'],
      hour: map['hour'],
      min: map['min'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'details': details,
      'muser': muser,
      'puser': puser,
      'day': day,
      'month': month,
      'year': year,
      'hour': hour,
      'min': min,
    };
  }
}
