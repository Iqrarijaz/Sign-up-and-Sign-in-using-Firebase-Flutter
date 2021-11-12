import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password/model/user_model.dart';
import 'package:email_password/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final conformPaswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name controller
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          hintText: "First Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return "Please Enter Your Name";
        }
        if (!regExp.hasMatch(value)) {
          return ("Enter valid name(Min. 3 character)");
        }
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
    );
//second name controller
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          hintText: "Last Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Your Last Name";
        }
        return null;
      },
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
    );

    //email controller
    final emailFiled = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Your Email";
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return "Please Enter a valid email";
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
    );

    //password controller
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      textInputAction: TextInputAction.next,
      obscureText: true,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return "Please Enter Your Password";
        }
        if (!regExp.hasMatch(value)) {
          return ("Please Enter Valid Password");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
    );

    //conform password controller
    final conformPasswordField = TextFormField(
      autofocus: false,
      controller: conformPaswordEditingController,
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
          // ignore: prefer_const_constructors
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          hintText: "Conform Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        if (conformPaswordEditingController.text!=passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        conformPaswordEditingController.text = value!;
      },
    );
    final signUpButton = Material(
      elevation: 5,
      color: context.theme.buttonColor,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        child: Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: GoogleFonts.lato().fontFamily,
              letterSpacing: 1.5,
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          //calling the signup function
         signUp(emailEditingController.text, passwordEditingController.text);
        },
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        minWidth: MediaQuery.of(context).size.width,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.theme.buttonColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: context.canvasColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
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
                  const SizedBox(
                    height: 45,
                  ),
                  firstNameField,
                  const SizedBox(height: 25),
                  secondNameField,
                  const SizedBox(height: 25),
                  emailFiled,
                  const SizedBox(height: 25),
                  passwordField,
                  const SizedBox(height: 25),
                  conformPasswordField,
                  const SizedBox(height: 25),
                  signUpButton,
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  void postDetailsToFirestore() async {
    //calling the firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //writing for values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
  }
}
