import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_google_signin/realtime_curd/real_view.dart';
//import 'package:flutter/material.dart';


class UpDateScreen extends StatefulWidget {
  String value;
  UpDateScreen({required this.value});

  @override
  State<UpDateScreen> createState() => _UpDateScreenState();
}

class _UpDateScreenState extends State<UpDateScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _updateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref().child('Datas');
    return Scaffold(
      appBar: AppBar(
        title:const Text('UpDate Screen'),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
           const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: _updateController,
              decoration:const InputDecoration(hintText: 'enter updaed value'),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'enter updatr';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  if (!_formkey.currentState!.validate()) {
                    return;
                  }
                  _formkey.currentState!.save();
                  String text = _updateController.text;
                  ref.child(widget.value).set(text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TaskViewPage()));
                },
                child:const Text('update'))
          ],
        ),
      ),
    );
  }
}
