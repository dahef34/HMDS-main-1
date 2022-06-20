class Patient {
  String? uid;
  String? name;
  String? last;
  String? sex;
  String? cases;
  String? age;
  List? appointment;

  Patient(
      {this.uid,
      this.name,
      this.last,
      this.sex,
      this.cases,
      this.age,
      this.appointment});

  factory Patient.fromMap(map) {
    return Patient(
      uid: map['uid'],
      name: map['name'],
      last: map['last'],
      sex: map['sex'],
      cases: map['cases'],
      age: map['age'],
      appointment: map['appointment'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'last': last,
      'sex': sex,
      'cases': cases,
      'age': age,
      'appointment': appointment,
    };
  }
}
