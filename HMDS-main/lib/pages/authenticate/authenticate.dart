import 'package:flutter/material.dart';
import 'package:hmd_system/pages/authenticate/login.dart';
import 'package:hmd_system/pages/home/home.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Loginpage(),
    );
  }
}
