import 'package:email_password/screens/home.dart';
import 'package:email_password/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //firebase authentication code
  final _auth=FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final emailFiled = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value){
        if (value!.isEmpty)
          {
            return "Please Enter Your Email";
          }
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
          {
            return "Please Enter a valid email";
          }
        return null;

      },
      onSaved: (value) {
        emailController.text = value!;
      },
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value){
        RegExp regExp=RegExp(r'^.{6,}$');
        if (value!.isEmpty)
          {
            return "Please Enter Your Password";
          }
        if (!regExp.hasMatch(value))
          {
            return("Please Enter Valid Password");
          }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
    );

    final loginButton = Material(
      elevation: 5,
      color: context.theme.buttonColor,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.lato().fontFamily,
          letterSpacing: 1.5),
        ),
        onPressed: () {
          login(emailController.text,passwordController.text);
        },
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        minWidth: MediaQuery.of(context).size.width,
      ),
    );
    return Scaffold(
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
                  SizedBox(
                    height: 45,
                  ),
                  emailFiled,
                  SizedBox(height: 25),
                  passwordField,
                  SizedBox(height: 25),
                  loginButton,
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account? ",style: TextStyle(
                          fontFamily: GoogleFonts.lato().fontFamily
                      ),),
                      GestureDetector(
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: context.theme.buttonColor, fontWeight: FontWeight.bold,
                          fontSize: 16,
                              fontFamily: GoogleFonts.lato().fontFamily),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
void login(String email,String password) async
{
  if(_formKey.currentState!.validate())
    {
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((uid) =>
      {
        Fluttertoast.showToast(msg:"Login Successful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()))
      }).catchError((e)
      {
        Fluttertoast.showToast(msg:e!.message);
      });
    }
}
}
