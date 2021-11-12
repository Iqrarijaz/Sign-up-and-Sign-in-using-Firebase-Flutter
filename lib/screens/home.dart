import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password/model/user_model.dart';
import 'package:email_password/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMAp(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final logOutButton = Material(
      elevation: 5,
      color: context.theme.buttonColor,
      borderRadius: BorderRadius.circular(30),
      child: IconButton(
        onPressed: () {
          logOut(context);
        },
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        icon: Icon(Icons.logout),
        iconSize: 24,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.buttonColor,
        centerTitle: true,
        title: Text(
          "Welcome",
          style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.lato().fontFamily,
              fontSize: 22,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome Back ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: GoogleFonts.lato().fontFamily),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontFamily: GoogleFonts.lato().fontFamily),
                ),
                Text(
                  "${loggedInUser.email}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontFamily: GoogleFonts.lato().fontFamily),
                ),
                SizedBox(
                  height: 10,
                ),
                logOutButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
