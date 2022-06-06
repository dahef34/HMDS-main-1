import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hmd_system/pages/home/home.dart';
import 'package:hmd_system/pages/model/Muser.dart';

class RegMuser extends StatefulWidget {
  const RegMuser({Key? key}) : super(key: key);

  @override
  _RegMuserState createState() => _RegMuserState();
}

class _RegMuserState extends State<RegMuser> {
  bool hidePassword = true;
  final formkey = GlobalKey<FormState>();
  final nameEC = new TextEditingController();
  final emailEC = new TextEditingController();
  final nricEC = new TextEditingController();
  final passwordEC = new TextEditingController();
  final confirmPasswordEC = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      autofocus: false,
      controller: nameEC,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Name Cannot Be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter A Valid Name");
        }
        return null;
      },
      onSaved: (value) {
        nameEC.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: 'Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEC,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]").hasMatch(value)) {
          return ("Please Enter Valid Email");
        }
        return null;
      },
      onSaved: (value) {
        nameEC.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final nricField = TextFormField(
      autofocus: false,
      controller: nricEC,
      keyboardType: TextInputType.number,
      validator: (value) {
        RegExp regex = new RegExp(r'[0-9]');
        if (value!.isEmpty) {
          return ("NRIC Cannot Be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter A Valid NRIC");
        }
        if (nricEC.text.length != 12) {
          return ("Enter A Valid NRIC");
        }
        return null;
      },
      onSaved: (value) {
        nricEC.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.card_membership),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "NRIC",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEC,
      obscureText: hidePassword,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password Is Required For Login");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Password");
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: InkWell(
          onTap: togglePasswordView,
          child: Icon(
            Icons.visibility,
          ),
        ),
      ),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEC,
      obscureText: hidePassword,
      validator: (value) {
        if (confirmPasswordEC.text != passwordEC.text) {
          return "Password Don't Match";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Confirm Pasword",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: InkWell(
          onTap: togglePasswordView,
          child: Icon(
            Icons.visibility,
          ),
        ),
      ),
    );

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue[400],
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEC.text, passwordEC.text);
        },
        child: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    nameField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    nricField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 20),
                    signUpButton,
                    SizedBox(height: 10),
                  ],
                ),
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

  void signUp(String email, String password) async {
    if (formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? mUser = _auth.currentUser;
    Muser muser = Muser();

    muser.email = mUser!.email;
    muser.uid = mUser.uid;
    muser.name = nameEC.text;
    muser.nric = nricEC.text;

    await firebaseFirestore
        .collection("mUsers")
        .doc(muser.uid)
        .set(muser.toMap());
    Fluttertoast.showToast(msg: "Account Created Successfully");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => homePage()), (route) => false);
  }
}
