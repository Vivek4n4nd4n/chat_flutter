import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_signin/realtime_curd/real_update.dart';

class TaskViewPage extends StatefulWidget {
  const TaskViewPage({Key? key}) : super(key: key);

  @override
  State<TaskViewPage> createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref().child('Datas');
    return Scaffold(
      appBar: AppBar(
        title: const Text('ViewT ask'),
      ),
      body: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 250,
                  child: Container(width: 170,color: Color.fromARGB(255, 74, 151, 195),
                    
                    // shape: RoundedRectangleBorder(
                    //   side: const BorderSide(
                    //     color: Colors.lime,
                    //   ),
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                      snapshot.value.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                        IconButton(
                            onPressed: () {
                              ref.child(snapshot.key!).remove();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpDateScreen(value: snapshot.key!),
                                  ));
                            },
                            icon: const Icon(
                              Icons.update,
                              color: Colors.green,
                            ))
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
