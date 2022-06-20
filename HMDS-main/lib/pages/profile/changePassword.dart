import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmd_system/pages/authenticate/login.dart';
import 'package:hmd_system/component/loading.dart';
import 'package:hmd_system/pages/settings.dart';

class changePassword extends StatefulWidget {
  @override
  _changePasswordState createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  final _formkey = GlobalKey<FormState>();
  var newPass = " ";
  final newPassController = TextEditingController();
  final newPassConfirmController = TextEditingController();
  final loggedInUser = FirebaseAuth.instance.currentUser;
  bool loading = false;
  bool hidePassword = true;

  @override
  void dispose() {
    newPassController.dispose();
    super.dispose();
  }

  changePassword() async {
    try {
      loading = true;
      await loggedInUser!.updatePassword(newPass);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Loginpage(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Passsword Updated! Please Login Again...',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      );
    } catch (error) {
      setState(() {
        loading = false;
      });
      const Text('Update Failed, Please Try Again Later!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const setPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final newPassField = TextFormField(
      autofocus: false,
      controller: newPassController,
      obscureText: hidePassword,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password Is Required");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Password \n(6 Characters & above..)");
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "New Password",
        hintText: "Enter New Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: InkWell(
          onTap: togglePasswordView,
          child: const Icon(
            Icons.visibility,
          ),
        ),
      ),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: newPassConfirmController,
      obscureText: hidePassword,
      validator: (value) {
        if (newPassConfirmController.text != newPassController.text) {
          return "Password Don't Match";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Confirm Pasword",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: InkWell(
          onTap: togglePasswordView,
          child: const Icon(
            Icons.visibility,
          ),
        ),
      ),
    );

    final updateButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue[400],
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            setState(() {
              newPass = newPassController.text;
            });
            changePassword();
          }
        },
        child: const Text(
          "Update",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.blueGrey[100],
            body: Center(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 50),
                        newPassField,
                        const SizedBox(height: 50),
                        confirmPasswordField,
                        const SizedBox(height: 50),
                        updateButton,
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  void togglePasswordView() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }
}
