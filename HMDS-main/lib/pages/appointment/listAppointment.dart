import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hmd_system/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hmd_system/model/Muser.dart';
import 'package:hmd_system/model/appoinment.dart';
import 'package:hmd_system/pages/profile/Userprofile.dart';
import 'package:hmd_system/component/aList.dart';
import 'package:provider/provider.dart';
import 'package:hmd_system/component/database.dart';

class listApt extends StatefulWidget {
  @override
  _listAptState createState() => _listAptState();
}

class _listAptState extends State<listApt> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Muser loggedInUser = Muser();
  Appointment apst = Appointment();

  List<Appointment> _aptList = [];

  @override
  void initState() {
    super.initState();
    loadList();
    loadUser();
  }

  void loadUser() {
    _firestore.collection("mUsers").doc(user!.uid).get().then((value) {
      loggedInUser = Muser.fromMap(value.data());
      setState(() {});
    });
  }

  Future loadList() async {
    _firestore.collection("mUsers").doc(user!.uid).get().then((snapshot) {
      for (var data in snapshot.data()?["appointment"]) {
        _firestore.collection("appointment").doc(apst.uid).get().then(
          (snapshot) {
            setState(() {
              _aptList =
                  List.from(data.docs.map((doc) => Appointment.fromMap(doc)));
            });
          },
        );
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
                        "Test",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${apst.title}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 16.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Text("Test List"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 100.0,
                      child: ListView.builder(
                        itemCount: _aptList.length,
                        itemBuilder: (context, index) {
                          return aList(_aptList[index] as Appointment);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
