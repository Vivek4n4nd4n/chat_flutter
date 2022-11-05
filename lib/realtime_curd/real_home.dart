import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_google_signin/realtime_curd/real_view.dart';

class RealHomePage extends StatefulWidget {
  String title;

  RealHomePage({required this.title, Key? key}) : super(key: key);

  @override
  State<RealHomePage> createState() => _RealHomePageState();
}

class _RealHomePageState extends State<RealHomePage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  final ref = FirebaseDatabase.instance.ref("Datas");
  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(hintText: 'enter task'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'please enter task';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      print("df${_controller.text}");

                      if (!_formkey.currentState!.validate()) {
                        print("not validated");
                        return;
                      }
                      print(_controller.text);
                      print("_controller.text");

                      _formkey.currentState!.save();

                      await ref.push()
                          .set(_controller.text)
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TaskViewPage(),
                              )));
                    } catch (e) {
                      print("exception: $e");
                    }
                  },
                  child: const Text('submit'))
            ],
          )),
    );
  }
}
