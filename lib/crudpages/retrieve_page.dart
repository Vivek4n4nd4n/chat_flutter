import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/chat/chatpage.dart';
import 'package:flutter_google_signin/crudpages/updatescreen.dart';

class RetrievePage extends StatefulWidget {
  const RetrievePage({Key? key}) : super(key: key);

  @override
  State<RetrievePage> createState() => _RetrievePageState();
}

class _RetrievePageState extends State<RetrievePage> {
  
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YOUR TASKS'),
        actions: [
          IconButton(
              onPressed: () {
               Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatPage()));
              },
              icon: const Icon(Icons.chat))
        ],
      ),
      body: StreamBuilder(
        stream:    FirebaseFirestore.instance.collectionGroup('Tasks').snapshots(),
           builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot task =
                    (snapshot.data as QuerySnapshot).docs[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.greenAccent,
                        width: MediaQuery.of(context).size.width - 10,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage("${task['image']}"),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${task['message']}',
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                ),
                                Text('${task['name']}'),


                                Text("${task['mail']}"),
                              ],
                            ),
                            Spacer(),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection('Tasks')
                                      .where('message', isEqualTo: task['message'])
                                      .get()
                                      .then((snapshot) => snapshot
                                          .docs.first.reference
                                          .delete());
                                },
                                child: const Icon(Icons.delete)),
                   user!.uid == task['uid'] ?       Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateScreen(
                                                  data: task['message'],
                                                )));
                                  },
                                  child: Icon(Icons.update)),
                            )
                            : SizedBox(width: 40,)
                          ],
                        ),
                      ),
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
