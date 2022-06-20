import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hmd_system/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hmd_system/model/Muser.dart';
import 'package:fluttertoast/fluttertoast.dart';

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final formkey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  Muser loggedInUser = Muser();
  final List<String> pos = ['Dr', 'Nurse'];
  final List<String> stt = [
    'Johor',
    'Kedah',
    'Kelantan',
    'Kuala Lumpur',
    'Labuan',
    'Malacca',
    'Negeri Sembilan',
    'Pahang',
    'Penang',
    'Perak',
    'Perlis',
    'Putrajaya',
    'Sabah',
    'Sarawak',
    'Selangor',
    'Terengganu'
  ];

  Future<void> updateUser(
      uid, name, post, dept, hosp, street, city, postcode, state, country) {
    return FirebaseFirestore.instance
        .collection("mUsers")
        .doc(user!.uid)
        .update({
          'name': name,
          'post': post,
          'dept': dept,
          'hosp': hosp,
          'street': street,
          'city': city,
          'postcode': postcode,
          'state': state,
          'country': country,
        })
        .then((value) => print("Profile Updated"))
        .catchError((error) => print("Update Failed: $error"));
  }

  delete(name, post, dept, hosp, street, city, postcode, state, country) {
    return FirebaseFirestore.instance
        .collection("mUsers")
        .doc(user!.uid)
        .delete()
        .then((value) => print("Profile Cleared"));
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("mUsers").doc(user!.uid).get().then(
      (value) {
        loggedInUser = Muser.fromMap(value.data());
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        elevation: 0,
        leading: const BackButton(),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const setPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                label: const Text(''),
              ),
            ],
          )
        ],
      ),
      body: Form(
        key: formkey,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('mUsers')
                .doc(user!.uid)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var data = snapshot.data!.data();
              var name = data!['name'];
              var post = data['post'];
              var dept = data['dept'];
              var hosp = data['hosp'];
              var street = data['street'];
              var city = data['city'];
              var postcode = data['postcode'];
              var state = data['state'];
              var country = data['country'];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    //name
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: name,
                        autofocus: false,
                        onChanged: (value) => name = value,
                        decoration: const InputDecoration(
                          labelText: 'Name: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Name Cannot Be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter A Valid Name");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DropdownButtonFormField(
                        value: post,
                        onChanged: (value) => post = value,
                        decoration: const InputDecoration(
                          labelText: 'Position: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                        ),
                        items: pos.map((post) {
                          return DropdownMenuItem(
                            value: post,
                            child: Text(post),
                          );
                        }).toList(),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: dept,
                        autofocus: false,
                        onChanged: (value) => dept = value,
                        decoration: const InputDecoration(
                          labelText: 'Department: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: hosp,
                        autofocus: false,
                        onChanged: (value) => hosp = value,
                        decoration: const InputDecoration(
                          labelText: 'Hospital: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: street,
                        autofocus: false,
                        onChanged: (value) => street = value,
                        decoration: const InputDecoration(
                          labelText: 'Street: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: city,
                        autofocus: false,
                        onChanged: (value) => city = value,
                        decoration: const InputDecoration(
                          labelText: 'City: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: postcode,
                        autofocus: false,
                        onChanged: (value) => postcode = value,
                        decoration: const InputDecoration(
                          labelText: 'Postcode: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DropdownButtonFormField(
                        value: state,
                        onChanged: (value) => state = value,
                        decoration: const InputDecoration(
                          labelText: 'State: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                        ),
                        items: stt.map<DropdownMenuItem<String>>((state) {
                          return DropdownMenuItem<String>(
                            value: state,
                            child: Text("$state"),
                          );
                        }).toList(),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: country,
                        autofocus: false,
                        onChanged: (value) => country = value,
                        decoration: const InputDecoration(
                          labelText: 'Country: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    //button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              updateUser(user!.uid, name, post, dept, hosp,
                                      street, city, postcode, state, country)
                                  .catchError((e) {
                                Fluttertoast.showToast(msg: e!.message);
                              });
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Profile Update Successfully");
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            delete(name, post, dept, hosp, street, city,
                                postcode, state, country)
                          },
                          child: const Text(
                            'Reset',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class _DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(50, 0);
    path.quadraticBezierTo(0, size.height / 2, 50, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
