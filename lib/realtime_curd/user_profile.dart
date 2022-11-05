import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref("userDatas");
    return Scaffold(
        appBar: AppBar(title: Text('User Profile Page')),
        body: FirebaseAnimatedList(
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              //  DocumentSnapshot task =
              //                   (snapshot.value as QuerySnapshot).docs[index];


              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(snapshot.value.toString(),)
                  // ),
                  Center(
                    child: Text(snapshot.value.toString())
                  ),
                ],
              );
            }));
  }
}
