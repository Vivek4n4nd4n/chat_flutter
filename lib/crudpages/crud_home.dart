import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/crudpages/retrieve_page.dart';

// ignore: camel_case_types
class CrudHome extends StatefulWidget {
  const CrudHome({Key? key}) : super(key: key);

  

  @override
  State<CrudHome> createState() => _CrudHomeState();
}

// ignore: camel_case_types
class _CrudHomeState extends State<CrudHome> {
  TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  final user = FirebaseAuth.instance.currentUser;
  void _showSuccessfulMessage(msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('from new - crud'),
              content: Text(msg),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('ok'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crud-Home')),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: taskController,
                  decoration: const InputDecoration(hintText: 'enter task'),
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'enter please';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (!_formkey.currentState!.validate()) {
                      return;
                    }
                    _formkey.currentState!.save();
                    String message = "task added successfully";
                    Map<String, dynamic> data = {'data':taskController.text,};
                    FirebaseFirestore.instance.collection('Tasks').add(data).then((value) => _showSuccessfulMessage(message));

                        // .collection("users").doc("task").collection("taskdata")
                        // .add(data)
                        // .then(
                          //  (value) => _showSuccessfulMessage(message));
                  },
                  child: const Text('Create Task')),
              const SizedBox(
                height: 13,
              ),
              // ignore: deprecated_member_use
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RetrievePage()));
                  },
                  child: const Text("View Task"))
            ],
          ),
        ),
      ),
    );
  }
}
