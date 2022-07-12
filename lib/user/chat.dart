import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messageController = TextEditingController();

  var chats = [
    {'message': 'asdf', 'time': '234', 'senderId': '2'},
    {'message': 'asadfdf', 'time': '234', 'senderId': '1'},
    {'message': 'asdfsfdg', 'time': '234', 'senderId': '2'},
    {'message': 'asddrf', 'time': '234', 'senderId': '4'},
  ];

  send() async {
    setState(() {
      chats.add({
        'message': messageController.text,
        'time': TimeOfDay.now().toString(),
        'senderId': '2'
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: double.infinity,
          height: 70,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                  suffix: IconButton(onPressed: send, icon: Icon(Icons.send)),
                  filled: true,
                  fillColor: Theme.of(context).primaryColor.withAlpha(200),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        // reverse: true,
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: chats[index]['senderId'] == '2'
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Chip(
                label: Text(chats[index]['message'].toString()),
              ),
            ],
          );
        },
      ),
    );
  }
}
