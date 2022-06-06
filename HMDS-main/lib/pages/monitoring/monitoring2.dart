import 'package:flutter/material.dart';
import 'package:hmd_system/pages/profile/Userprofile.dart';
import 'package:hmd_system/pages/settings.dart';

class monitor2 extends StatefulWidget {
   const monitor2({Key? key}) : super(key: key);
  @override
  _monitor2State createState() => _monitor2State();
}

class _monitor2State extends State<monitor2> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        elevation: 0.0,
        title: Text(
          'Monitoring',
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
                    MaterialPageRoute(builder: (context) => userProfile()),
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
                    MaterialPageRoute(builder: (context) => userProfile()),
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            floating: false,
            expandedHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Mr. Arno Geronimo',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SliverFixedExtentList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[200],
                    ),
                    child: Text(
                      '24, Coronary Heart Disease',
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => userProfile()),
                        );
                      },
                      child: Text(
                        'Patient Personal Details',
                        style: TextStyle(
                          color: Colors.blue[600],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blueGrey[100],
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[100],
                    ),
                    child: Text(
                      'Heart Rate (bpm): ',
                      textAlign: TextAlign.left,
                    ),
                  ),

                  Container(),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[100],
                    ),
                    child: Text(
                      'Oxygen Level (SpO2): ',
                      textAlign: TextAlign.left,
                    ),
                  ),

                  Container(),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[100],
                    ),
                    child: Text(
                      'Body Temperature (°C): ',
                      textAlign: TextAlign.left,
                    ),
                  ),

                  Container(),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[100],
                    ),
                    child: Text(
                      'Room Temperature (°C): ',
                      textAlign: TextAlign.left,
                    ),
                  ),

                  Container(),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width:3.0),
                      color: Colors.blueGrey[200],
                    ),
                    child: Text(
                      'Upcoming Appointments with Patient: ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[300],
                    ),
                    child: Text(
                      '02.02.2022 (WED) 08.00 AM - Second Visit'
                          '\n'
                          '\n03.02.2022 (THU) 10.00 AM - Body Checkup'
                          '\n'
                          '\n17.02.2022 (THU) 10.00 AM - Third Checkup',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              itemExtent: 80),
        ],
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
