
import 'package:flutter/material.dart';


import 'package:flutter_google_signin/provider/google_sin-in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_google_signin/screens/loginscreen.dart';


import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context)=>GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter ',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home:
      const  Login_Screen()
       // MyHome(title: title)
      
  
        //SpeetchToText()
      //  const HomePage(),
      ),
        );
  }
}
