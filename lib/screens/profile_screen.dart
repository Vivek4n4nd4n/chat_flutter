import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/crudpages/crud_home.dart';
import 'package:flutter_google_signin/provider/google_sin-in.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('profile Screen'),
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user!.photoURL!),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'name :' + user!.displayName!,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Email :' + user!.email!,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
             const SizedBox(
              height: 20,
            ),
            Text(
              'Uid :' + user!.uid,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>const CrudHome()));
                },
                child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}
