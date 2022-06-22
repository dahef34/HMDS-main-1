import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hmd_system/pages/appointment/editAppointment.dart';
import 'package:hmd_system/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hmd_system/model/Muser.dart';
import 'package:hmd_system/model/appoinment.dart';
import 'package:hmd_system/pages/profile/Userprofile.dart';

class ListApt extends StatefulWidget {
  const ListApt({Key? key}) : super(key: key);

  @override
  _listAptState createState() => _listAptState();
}

class _listAptState extends State<ListApt> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Muser loggedInUser = Muser();
  final List<Appointment> _aptList = [];

  Future<List<Appointment>?> loadList() async {
    await _firestore
        .collection("mUsers")
        .doc(user!.uid)
        .get()
        .then((snapshot) async {
      loggedInUser = Muser.fromMap(snapshot.data());
      for (var apts in snapshot.data()?["appointment"]) {
        var _appointment =
            await _firestore.collection("appointment").doc(apts).get();

        _aptList.add(Appointment.fromMap(_appointment.data()));
      }
    });
    return _aptList;
  }

  Future<void> deleteAppointment(Appointment apt) async {
    await FirebaseFirestore.instance
        .collection('appointment')
        .doc(apt.uid)
        .delete();

    await FirebaseFirestore.instance
        .collection("mUsers")
        .doc(user!.uid)
        .update({
      "appointment": FieldValue.arrayRemove([apt.uid!])
    });
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
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Builder(builder: (context) {
          return Center(
            child: FutureBuilder(
              future: loadList(),
              builder: (context, snapshot) {
                if (snapshot.hasData && _aptList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: _aptList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ExpandablePanel(
                          header: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "${_aptList[index].title} with ${_aptList[index].puser}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          collapsed: Text(
                            "\t${_aptList[index].day} ${_aptList[index].month} ${_aptList[index].year}"
                            "\t | \t ${_aptList[index].hour}:${_aptList[index].min}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          expanded: ListTile(
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
                              width: 120,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    width: 55,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditApt(
                                              appointment: _aptList[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(Icons.edit),
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                          width: 2,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                    width: 55,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await deleteAppointment(
                                            _aptList[index]);
                                        await refresh();
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
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
          );
        }),
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

  Future<void> refresh() async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => const ListApt(),
            transitionDuration: const Duration(seconds: 2)));
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
