import 'package:chatting_app1/features/auth/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // Firestore doc.data() returns Map<String, dynamic> for documents
        final Map<String, dynamic> data = Map<String, dynamic>.from(doc.data());
        // ensure the returned map always contains the document id as 'uid'
        return {'uid': doc.id, ...data};
      }).toList();
    });
  }

  //send messages
  Future<void> sendMessages(String receiverId, message) async {
    //get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    Message newMessage = Message(
      senderid: currentUserId,
      message: message,
      senderemail: currentUserEmail,
      receiverid: receiverId,
      timestamp: timestamp,
    );
    //construct chat roon id
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //sort the ids that ensure that the 2 people have same chatroomid
    String chatroomid = ids.join('_');
    await _firestore
        .collection("chat_rooms")
        .doc(chatroomid)
        .collection("messages")
        .add(newMessage.tomap());
    //add new messages to database
  }

  //get messages
  Stream<QuerySnapshot> getmessages(String userid, otheruserid) {
    List<String> ids = [userid, otheruserid];
    ids.sort();
    String chatroomid = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatroomid)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
