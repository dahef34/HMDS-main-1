import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hmd_system/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hmd_system/model/Muser.dart';
import 'package:hmd_system/model/appoinment.dart';
import 'package:hmd_system/pages/profile/Userprofile.dart';

class listApt extends StatefulWidget {
  @override
  _listAptState createState() => _listAptState();
}

class _listAptState extends State<listApt> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;

  Muser loggedInUser = Muser();
  Appointment apst = Appointment();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() {
    _firestore.collection("mUsers").doc(user!.uid).get().then((value) {
      this.loggedInUser = Muser.fromMap(value.data());
      setState(() {});
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
          'Appointment List',
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
                      builder: (context) => userProfile(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                label: Text(''),
              ),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                child: Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${loggedInUser.name}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Test List",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${loggedInUser.appointment}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
      endDrawer: ClipPath(
        clipper: _DrawerClipper(),
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(top: 48.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Notifications",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[200],
        onPressed: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
        child: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
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
