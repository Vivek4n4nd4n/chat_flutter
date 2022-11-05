import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
// ignore: unused_import
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Message> messages = [
    Message(
        text: 'Hai what are You Purchasing',
        date: DateTime.now().subtract(Duration(days: 3, minutes: 4)),
        isSentByMe: true
        // true,
        ),
    Message(
      text: 'banana',
      date: DateTime.now().subtract(Duration(days: 3, minutes: 5)),
      isSentByMe: false,
    ),
    Message(
      text: 'How much am i told to purchase',
      date: DateTime.now().subtract(Duration(days: 3, minutes: 6)),
      isSentByMe: true,
    ),
    Message(
      text: 'Two',
      date: DateTime.now().subtract(Duration(days: 3, minutes: 7)),
      isSentByMe: false,
    ),
    Message(
      text: 'How much in your hand',
      date: DateTime.now().subtract(Duration(days: 3, minutes: 4)),
      isSentByMe: true,
    ),
    Message(
      text: 'one',
      date: DateTime.now().subtract(Duration(days: 3, minutes: 5)),
      isSentByMe: false,
    ),
    Message(
      text: 'Where is another one',
      date: DateTime.now().subtract(Duration(days: 3, minutes: 6)),
      isSentByMe: true,
    ),
    Message(
      text: 'that is it',
      date: DateTime.now().subtract(Duration(days: 3, minutes: 1)),
      isSentByMe: false,
    ),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Chat app'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
                padding: EdgeInsets.all(8),
                reverse: false,
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                floatingHeader: true,
                elements: messages,
                groupBy: (message) => DateTime(
                    message.date.year, message.date.month, message.date.day),
                groupHeaderBuilder: (Message message) => SizedBox(
                    height: 40,
                    child: Center(
                      child: Card(
                        color: Color.fromARGB(255, 126, 202, 240),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DateFormat.yMMMd().format(message.date),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )),
                itemBuilder: (context, Message message) => Align(
                    alignment: message.isSentByMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(message.text),
                      ),
                    ))),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      color: Colors.white,
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'type your text here'),
                        onSubmitted: (text) {
                          final message = Message(
                              text: text,
                              date: DateTime.now(),
                              isSentByMe: true);
                          setState(() => messages.add(message));
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.send),
              ))
            ],
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final DateTime date;

  final bool isSentByMe;
  Message({required this.text, required this.date, required this.isSentByMe});
}