import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/provider/google_sin-in.dart';
import 'package:flutter_google_signin/screens/home_screens.dart';
import 'package:flutter_google_signin/screens/profile_screen.dart';
//import 'package:google_sign_in/google_sign_in.dart';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final user = FirebaseAuth.instance.currentUser;

  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 122, 171),
        title: const Text(
          'The Kntag',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
                child: SizedBox(
              height: 100,
              width: 100,
              child: Image(image: AssetImage("assets/Logo.png")),
            )),
            //   const FlutterLogo(size: 160),
            // ignore: prefer_const_constructors
            const SizedBox(
              height: 100,
            ),
            const Text(
              'Sign in With Google',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                  Map<String, dynamic> userdata = {
                    "name": user?.displayName,
                    'email': user?.email,
                    'uid': user?.uid,
                    'image': user?.photoURL
                  };
                  FirebaseFirestore.instance.collection('users').doc(user?.uid).set(userdata);
                },
                label: const Text('Signup with google'),
                style: ElevatedButton.styleFrom(
                 // foregroundColor: Colors.black,
                 // backgroundColor: Colors.white,
                ),
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Color.fromARGB(255, 244, 162, 54),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
