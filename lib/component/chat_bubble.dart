import 'package:chatting_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool iscurrentuser;
  const ChatBubble(
      {super.key, required this.message, required this.iscurrentuser});

  @override
  Widget build(BuildContext context) {
    bool isdarkmode =
        Provider.of<ThemeProvider>(context, listen: false).isdarkmode;
    return Container(
        decoration: BoxDecoration(
            color: iscurrentuser
                ? (isdarkmode ? Colors.green : Colors.green.shade400)
                : (isdarkmode ? Colors.grey.shade800 : Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 25,
        ),
        child: Text(
          message,
          style: TextStyle(
            color: iscurrentuser
                ? Colors.white
                : (isdarkmode ? Colors.white : Colors.black),
          ),
        ));
  }
}
