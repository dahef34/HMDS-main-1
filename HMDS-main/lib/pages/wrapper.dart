import 'package:flutter/material.dart';
import 'package:hmd_system/pages/authenticate/authenticate.dart';
import 'package:hmd_system/pages/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //return either home or authenticate
    return Authenticate();
  }
}
