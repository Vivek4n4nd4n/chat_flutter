import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/crudpages/retrieve_page.dart';
//import 'package:flutter_google_signin/crudpages/crud_home.dart';
//import 'package:flutter_google_signin/crudpages/crud_home.dart';
//import 'package:flutter_google_signin/crudpages/retrieve_page.dart';

// ignore: must_be_immutable
class UpdateScreen extends StatefulWidget {
  String data;

  UpdateScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController textController = TextEditingController();
  void showSuccessfulMessage(msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('from new - crud'),
              content: Text(msg),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                    
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const RetrievePage()));
                    },
                    child: const Text('ok'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update data'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: textController,
                decoration: const InputDecoration(hintText: 'Update data'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  String message = "Data updated Sucessfully";
                  FirebaseFirestore.instance
                      .collection('Tasks')
                      .where('data', isEqualTo: widget.data)
                      .get()
                      .then((snapshot) => snapshot.docs.first.reference
                          .update({'data': textController.text}));
                  showSuccessfulMessage(message);
                },
                child: const Text('Update'))
          ],
        ),
      ),
    );
  }
}
