import 'dart:async';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

import 'chatmessages.dart';

class AIPage extends StatefulWidget {
  AIPage({Key? key}) : super(key: key);

  @override
  AIPageState createState() => AIPageState();
}

class AIPageState extends State<AIPage> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _sendMessage() {
    ChatMessage _message = ChatMessage(text: _controller.text, sender: "user");
    setState(() {
      _messages.insert(0, _message);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
              controller: _controller,
              onSubmitted: (value) => _sendMessage(),
              decoration:
                  InputDecoration.collapsed(hintText: "Send a Message")),
        ),
        IconButton(
            onPressed: () => _sendMessage(), icon: const Icon(Icons.send))
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("open AI")),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                      reverse: true,
                      padding: Vx.m8,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return _messages[index];
                      })),
              Container(
                decoration: BoxDecoration(color: context.cardColor),
                child: _buildTextComposer(),
              )
            ],
          ),
        ));
  }
}
