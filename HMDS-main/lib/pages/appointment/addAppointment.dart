import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hmd_system/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hmd_system/model/Muser.dart';
import 'package:hmd_system/model/appoinment.dart';
import 'package:hmd_system/pages/profile/Userprofile.dart';

class AddApt extends StatefulWidget {
  const AddApt({
    Key? key,
  }) : super(key: key);

  @override
  _AddAptState createState() => _AddAptState();
}

class _AddAptState extends State<AddApt> {
  String? title;
  String? muser;
  String? puser;
  String? details;
  String? day;
  String? month;
  String? hour;
  String? min;
  String? year;

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

  Future<void> addAppointment(Appointment apt) async {
    await FirebaseFirestore.instance
        .collection('appointment')
        .doc(apt.uid)
        .set(apt.toMap());

    await FirebaseFirestore.instance
        .collection("mUsers")
        .doc(user!.uid)
        .update({
      "appointment": FieldValue.arrayUnion([apt.uid!])
    });
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
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                    Form.of(primaryFocus!.context!)!.save();
                  },
                        decoration: const InputDecoration(
                          hintText: "Appointment Title",
                          labelText: "Appointmet Title",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String? value) {
                          if (value != null) {
                            setState(() {
                              title = value;
                            });
                          }
                        },
                      ),
                      TextFormField(
                         onChanged: (value) {
                    Form.of(primaryFocus!.context!)!.save();
                  },
                        decoration: const InputDecoration(
                          hintText: "Appointment Details",
                          labelText: "Appointmet Details",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String? value) {
                          if (value != null) {
                            setState(() {
                              details = value;
                            });
                          }
                        },
                      ),
                      TextFormField(
                         onChanged: (value) {
                    Form.of(primaryFocus!.context!)!.save();
                  },
                        decoration: const InputDecoration(
                          hintText: "Appointment Muser",
                          labelText: "Appointmet Muser",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String? value) {
                          if (value != null) {
                            setState(() {
                              muser = value;
                            });
                          }
                        },
                      ),
                      TextFormField(
                         onChanged: (value) {
                    Form.of(primaryFocus!.context!)!.save();
                  },
                        decoration: const InputDecoration(
                          hintText: "Appointment Puser",
                          labelText: "Appointmet Puser",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String? value) {
                          if (value != null) {
                            setState(() {
                              puser = value;
                            });
                          }
                        },
                      ),
                      TextFormField(
                         onChanged: (value) {
                    Form.of(primaryFocus!.context!)!.save();
                  },
                        decoration: const InputDecoration(
                          hintText: "Appointment Day",
                          labelText: "Appointmet Day",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String? value) {
                          if (value != null) {
                            setState(() {
                              day = value;
                            });
                          }
                        },
                      ),
                      TextFormField(
                         onChanged: (value) {
                    Form.of(primaryFocus!.context!)!.save();
                  },
                        decoration: const InputDecoration(
                          hintText: "Appointment Month",
                          labelText: "Appointmet Month",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String? value) {
                          if (value != null) {
                            setState(() {
                              month = value;
                            });
                          }
                        },
                      ),
                      TextFormField(
                         onChanged: (value) {
                    Form.of(primaryFocus!.context!)!.save();
                  },
                        decoration: const InputDecoration(
                          hintText: "Appointment Year",
                          labelText: "Appointmet Year",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String? value) {
                          if (value != null) {
                            setState(() {
                              year = value;
                            });
                          }
                        },
                      ),
                      TextFormField(
                         onChanged: (value) {
                    Form.of(primaryFocus!.context!)!.save();
                  },
                        decoration: const InputDecoration(
                          hintText: "Appointment Hour",
                          labelText: "Appointmet Hour",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String? value) {
                          if (value != null) {
                            setState(() {
                              hour = value;
                            });
                          }
                        },
                      ),
                      TextFormField(
                         onChanged: (value) {
                    Form.of(primaryFocus!.context!)!.save();
                  },
                        decoration: const InputDecoration(
                          hintText: "Appointment Minute",
                          labelText: "Appointmet Minute",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String? value) {
                          if (value != null) {
                            setState(() {
                              min = value;
                            });
                          }
                        },
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await addAppointment(Appointment(
                                day: day,
                                uid: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                title: title,
                                details: details,
                                muser: muser,
                                puser: puser,
                                month: month,
                                year: year,
                                hour: hour,
                                min: min));
                            Navigator.of(context).pop();
                          },
                          child: const Text('Submit Appointmet'))
                    ],
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
