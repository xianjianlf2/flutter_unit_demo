import 'package:flutter/material.dart';
import 'package:flutter_unit_application/widgets/chat_input.dart';
import 'widgets/chat_bubble.dart';

class ChatWindowPage extends StatefulWidget {
  const ChatWindowPage({Key? key}) : super(key: key);

  @override
  State<ChatWindowPage> createState() => _ChatWindowPageState();
}

class _ChatWindowPageState extends State<ChatWindowPage> {
  List messageList = [
    {
      "msg": 'Hello world',
      "isSender": false,
    },
    {
      "msg": 'yeap',
      "isSender": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text('Xiao Ming'),
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: BubbleNormal(
                        text: messageList[index]['msg'],
                        isSender: messageList[index]['isSender'],
                        color: Colors.blue,
                        tail: true,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ));
                }),
          ),
          ChatInput(
            sendMessage: _sendMessage,
          ),
        ],
      ),
    );
  }

  _sendMessage(String value) {
    if (value != '') {
      setState(() {
        messageList.add({"msg": value, "isSender": true});
      });
    }
  }
}
