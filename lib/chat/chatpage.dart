import 'package:flutter/material.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.green[100],
      appBar: AppBar(title:const Text('ChatPage'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
           Container(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(color: Colors.white,
                height: 50,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "chat here"
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}