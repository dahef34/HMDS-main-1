import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hmd_system/pages/appointment/listAppointment.dart';
import 'package:hmd_system/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hmd_system/model/Muser.dart';
import 'package:hmd_system/model/appoinment.dart';
import 'package:hmd_system/pages/profile/Userprofile.dart';

class EditApt extends StatefulWidget {
  final Appointment appointment;
  const EditApt({Key? key, required this.appointment}) : super(key: key);

  @override
  _EditAptState createState() => _EditAptState();
}

class _EditAptState extends State<EditApt> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final User? user = FirebaseAuth.instance.currentUser;
  late final Muser loggedInUser;

  Future<Muser> getUser() async {
    if (loggedInUser.uid == user?.uid) {
      return loggedInUser;
    }
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      final snapshot = await FirebaseFirestore.instance
          .collection("mUsers")
          .doc(user!.uid)
          .get();
      loggedInUser = Muser.fromMap(snapshot.data());
    });
    return loggedInUser;
  }

  Future<void> updateAppointment(Appointment apt) async {
    await FirebaseFirestore.instance
        .collection('appointment')
        .doc(apt.uid)
        .set(apt.toMap());
  }

  Future<void> deleteAppointment(Appointment apt) async {
    await FirebaseFirestore.instance
        .collection('appointment')
        .doc(apt.uid)
        .delete();
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
          'Edit Appointment',
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
                      builder: (context) => const userProfile(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                label: const Text(''),
              ),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Form(
                  onChanged: () {
                    Form.of(primaryFocus!.context!)!.save();
                  },
                  child: TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    initialValue: widget.appointment.title,
                    decoration: const InputDecoration(
                      hintText: "Appointment Title",
                      labelText: "Appointmet Title",
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (String? value) async {
                      if (value != null) {
                        setState(() {
                          widget.appointment.title = value;
                        });
                        await updateAppointment(widget.appointment);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: ClipPath(
        clipper: _DrawerClipper(),
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(top: 48.0),
            child: Column(
              children: const <Widget>[
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
        child: const Icon(
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
