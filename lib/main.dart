import 'package:email_password/screens/home.dart';
import 'package:email_password/screens/login.dart';
import 'package:email_password/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      //light theme self defined
      darkTheme: MyTheme.darkTheme(context),
      title: 'Notify',

      home: LoginScreen(),
    );
  }
}
