import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/chat/chatpage.dart';
import 'package:flutter_google_signin/crudpages/crud_home.dart';
import 'package:flutter_google_signin/provider/google_sin-in.dart';
import 'package:flutter_google_signin/realtime_curd/real_home.dart';
import 'package:provider/provider.dart';

import '../test/chat_test.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatPage()));
                },
                child: const Text('Submit')),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.amber,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collectionGroup('Tasks')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              (snapshot.data as QuerySnapshot).docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot task =
                                (snapshot.data as QuerySnapshot).docs[index];

                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                color: user!.uid == task['uid']
                                    ? Colors.greenAccent
                                    : Colors.green[100],
                                height: 140,
                                width: 320,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage("${task['image']}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${task['name']}',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 25),
                                          ),
                                          Text('${task['message']}'),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          // Text('${task['message']}'),
                                          // Text(user!.uid)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    })),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RealHomePage(
                                title: 'Real CRUD',
                              )));
                },
                child: Text('RealTime Page'))
          ],
        ),
      ),
    );
  }
}
