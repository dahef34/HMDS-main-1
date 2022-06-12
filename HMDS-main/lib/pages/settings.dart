import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hmd_system/pages/authenticate/login.dart';
import 'package:hmd_system/pages/authenticate/reset.dart';
import 'package:hmd_system/pages/profile/changePassword.dart';

class setPage extends StatefulWidget {
  const setPage({Key? key}) : super(key: key);

  @override
  _setPageState createState() => _setPageState();
}

class _setPageState extends State<setPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        elevation: 0.0,
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 250.0, horizontal: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => changePassword(),
                    ),
                  );
                },
                child: Text(
                  'Change Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  logout(context);
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Loginpage()));
  }
}
