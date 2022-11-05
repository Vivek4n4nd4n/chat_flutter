import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:grouped_list/grouped_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final TextEditingController textController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text('ChatPage'),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.80,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
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
                        reverse: true,
                          itemCount:
                              (snapshot.data! as QuerySnapshot).docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot task =
                                (snapshot.data! as QuerySnapshot).docs[index];
                            return SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: user!.uid == task['uid']
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onLongPress: (() {
                                            _showGialog(task);
                                          }),
                                          child: FittedBox(
                                              child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            child: Card(
                                                color: user!.uid == task['uid']
                                                    ? Colors.greenAccent
                                                    : Colors.green[100],
                                                child: user!.uid == task['uid']
                                                    ? Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                    '${task['name']}'),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    '${task['message']}',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .deepPurple),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(task[
                                                                    'image']),
                                                          ),
                                                        ],
                                                      )
                                                    : Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(task[
                                                                    'image']),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                    '${task['name']}'),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    '${task['message']}',
                                                                    style: const TextStyle(
                                                                        color: Color.fromARGB(255, 7, 1, 1)),
                                                                  ),
                                                                ),
                                                                //SizedBox(height: 50,)
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                          )),
                                        )),
                                  ]),
                            );
                          });
                    }),
              ),
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "chat here"),
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'enter please';
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: (() {
                          if (!_formkey.currentState!.validate()) {
                            return;
                          }
                          _formkey.currentState!.save();
                          Map<String, dynamic> data = {
                            'message': textController.text,
                            'uid': user!.uid,
                            "name": user!.displayName,
                            'image': user!.photoURL,
                            'mail': user!.email
                          };
                          FirebaseFirestore.instance
                              .collection('Tasks')
                              .add(data);
                        }),
                        icon: const Icon(Icons.send))
                  ])),
            ],
          ),
        ),
      ),
    );
  }

  _showGialog(task) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Are you sure'),
              content: Text('delete'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('Tasks')
                          .where('message', isEqualTo: task['message'])
                          .get()
                          .then((snapshot) =>
                              snapshot.docs.first.reference.delete());

                      Navigator.pop(context);
                    },
                    child: const Text('ok')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'))
              ],
            ));
  }
}
