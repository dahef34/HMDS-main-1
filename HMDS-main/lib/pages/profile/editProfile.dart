import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hmd_system/pages/settings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hmd_system/pages/model/Muser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final formkey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  Muser loggedInUser = Muser();

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
        this.loggedInUser = Muser.fromMap(value.data());
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
        leading: BackButton(),
        title: Text(
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
                      builder: (context) => setPage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                label: Text(''),
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
                return Center(
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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    //name
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: name,
                        autofocus: false,
                        onChanged: (value) => name = value,
                        decoration: InputDecoration(
                          labelText: 'Name: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
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
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: post,
                        autofocus: false,
                        onChanged: (value) => post = value,
                        decoration: InputDecoration(
                          labelText: 'Position: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: dept,
                        autofocus: false,
                        onChanged: (value) => dept = value,
                        decoration: InputDecoration(
                          labelText: 'Department: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: hosp,
                        autofocus: false,
                        onChanged: (value) => hosp = value,
                        decoration: InputDecoration(
                          labelText: 'Hospital: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: street,
                        autofocus: false,
                        onChanged: (value) => street = value,
                        decoration: InputDecoration(
                          labelText: 'Street: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: city,
                        autofocus: false,
                        onChanged: (value) => city = value,
                        decoration: InputDecoration(
                          labelText: 'City: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: postcode,
                        autofocus: false,
                        onChanged: (value) => postcode = value,
                        decoration: InputDecoration(
                          labelText: 'Postcode: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: state,
                        autofocus: false,
                        onChanged: (value) => state = value,
                        decoration: InputDecoration(
                          labelText: 'State: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: country,
                        autofocus: false,
                        onChanged: (value) => country = value,
                        decoration: InputDecoration(
                          labelText: 'Country: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Cannot Be Empty");
                          }
                          return null;
                        },
                      ),
                    ),

                    //button
                    Container(
                      child: Row(
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
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {
                              delete(name, post, dept, hosp, street, city,
                                  postcode, state, country)
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey),
                          ),
                        ],
                      ),
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
