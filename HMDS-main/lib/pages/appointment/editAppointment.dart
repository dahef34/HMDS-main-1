import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hmd_system/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hmd_system/model/Muser.dart';
import 'package:hmd_system/model/appoinment.dart';
import 'package:hmd_system/pages/profile/Userprofile.dart';

class EditApt extends StatefulWidget {
  final Appointment appointment;
  const EditApt({Key? key, required this.appointment}) : super(key: key);

  @override
  _editAptState createState() => _editAptState();
}

class _editAptState extends State<EditApt> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final User? user = FirebaseAuth.instance.currentUser;
  late Muser loggedInUser = Muser();
  final List<Appointment> _aptList = [];

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

  Future<List<Appointment>?> loadList() async {
    final List<String>? apts =
        await getUser().then((value) => value.appointment as List<String>?);
    if (apts != null && apts.isNotEmpty) {
      _aptList.clear();
      for (final String apt in apts) {
        var _appointment = await FirebaseFirestore.instance
            .collection("appointment")
            .doc(apt)
            .get();

        _aptList.add(Appointment.fromMap(_appointment.data()));
      }
      return _aptList;
    } else {
      return null;
    }
  }

  Future<List<Appointment>?> addAppointment(Appointment apt) async {
    _aptList.add(apt);
    List<String?> apptUids = _aptList.map((e) => e.uid).toList();
    await FirebaseFirestore.instance
        .collection("mUsers")
        .doc('${loggedInUser.uid}')
        .set({"appointment": apptUids}).then((snapshot) async {
      await FirebaseFirestore.instance
          .collection('appointment')
          .doc(apt.uid)
          .set(apt.toMap());
    });
    return loadList();
  }

  Future<List<Appointment>?> updateAppointment(Appointment apt) async {
    await FirebaseFirestore.instance
        .collection('appointment')
        .doc(apt.uid)
        .set(apt.toMap());

    return loadList();
  }

  Future<List<Appointment>?> deleteAppointment(Appointment apt) async {
    await FirebaseFirestore.instance
        .collection('appointment')
        .doc(apt.uid)
        .delete();

    return loadList();
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
        child: FutureBuilder(
          future: loadList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: _aptList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          subtitle: Text(
                            "${_aptList[index].day} ${_aptList[index].month} ${_aptList[index].year}"
                            "\t | \t ${_aptList[index].hour}:${_aptList[index].min}"
                            "\n${_aptList[index].details}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          trailing: SizedBox(
                            height: 35,
                            width: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                deleteAppointment(_aptList[index]);
                              },
                              child: const Icon(Icons.delete),
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 2,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
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
