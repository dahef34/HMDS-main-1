import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hmd_system/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hmd_system/model/Muser.dart';
import 'package:hmd_system/model/appoinment.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditAppt extends StatefulWidget {
  const EditAppt({Key? key}) : super(key: key);

  @override
  _editApptState createState() => _editApptState();
}

class _editApptState extends State<EditAppt> {
  final formkey = GlobalKey<FormState>();

  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Muser loggedInUser = Muser();
  Appointment apts = Appointment();

  @override
  void initState() {
    super.initState();
    _firestore.collection("appoinitment").doc(apts.uid).get().then(
      (value) {
        apts = Appointment.fromMap(value.data());
        setState(() {});
      },
    );
  }

  Future<void> UpdateAppt(
      uid, title, details, muser, puser, day, month, year, hour, min) {
    return _firestore
        .collection("mUsers")
        .doc(user!.uid)
        .get()
        .then((snapshot) async {
      loggedInUser = Muser.fromMap(snapshot.data());
      for (var apt in snapshot.data()?["appoinment"]) {
        await _firestore
            .collection("appointment")
            .doc(apts.uid)
            .update({
              'title': title,
              'details': details,
              'muser': muser,
              'puser': puser,
              'day': day,
              'month': month,
              'year': year,
              'hour': hour,
              'min': min,
            })
            .then((value) => print("Appointment Updated"))
            .catchError((e) => print("Update Failed: $e"));
      }
    });
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
            future: _firestore.collection("appointment").doc(apts.uid).get(),
            builder: (_, snapshot) {
              var data = snapshot.data!.data();
              var title = data!['title'];

              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          initialValue: title,
                          autofocus: false,
                          onChanged: (value) => title = value,
                          decoration: InputDecoration(
                            labelText: 'Title: ',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle:
                                TextStyle(color: Colors.red, fontSize: 15),
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{3,}$');
                            if (value!.isEmpty) {
                              return ("Title Cannot Be Empty");
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://cdn.shopify.com/s/files/1/2594/8992/products/pvc_nothing_transparent_grande.png?v=1526830599',
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}
