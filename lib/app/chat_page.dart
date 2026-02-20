import 'package:chatting_app1/features/component/chat_bubble.dart';
import 'package:chatting_app1/features/component/my_textfield.dart';
import 'package:chatting_app1/features/auth/authservice.dart';
import 'package:chatting_app1/features/auth/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverid;
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverid,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messagecontroller = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  FocusNode myfocusnode = FocusNode();
  @override
  void initState() {
    super.initState();
    myfocusnode.addListener(() {
      if (myfocusnode.hasFocus) {
        //cause a delay that the keyboard has time to show up
        //then the amount of remaining space will e calculated
        //then scroll down
        Future.delayed(Duration(milliseconds: 500), () => scrolldown());
      }
    });
  }

  @override
  void dispose() {
    myfocusnode.dispose();
    _messagecontroller.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrolldown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendmessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatService.sendMessages(
        widget.receiverid,
        _messagecontroller.text,
      );
      _messagecontroller.clear();
    }
    scrolldown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          //display messages
          Expanded(child: _buildmessagesList()),
          _builduserinput(),
        ],
      ),
    );
  }

  Widget _buildmessagesList() {
    String senderid = _authService.getCurrentUser()!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getmessages(widget.receiverid, senderid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("error");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading...");
        }
        final docs = snapshot.data!.docs;
        return ListView(
          controller: _scrollController,
          children: docs.map((doc) => _buildmessageitem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildmessageitem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //is current user
    bool isCurrentUser = data['senderid'] == _authService.getCurrentUser()!.uid;
    // align messages
    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["messages"], iscurrentuser: isCurrentUser),
        ],
      ),
    );
  }

  //user input
  Widget _builduserinput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              controller: _messagecontroller,
              hintText: "type a message",
              obscureText: false,
              focusNode: myfocusnode,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendmessage,
              icon: Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
