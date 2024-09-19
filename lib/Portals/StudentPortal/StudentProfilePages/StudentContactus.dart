import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_fund_collection/CustomWidgets/Snakbar.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class StudentChatPage extends StatefulWidget {
  @override
  _StudentChatPageState createState() => _StudentChatPageState();
}

class _StudentChatPageState extends State<StudentChatPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  void _sendMessage() async {
    DocumentSnapshot<Map<String,dynamic>> UserData = await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
    if (_messageController.text.trim().isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('Chats')
          .doc(user!.uid).set({
        'SenderName':UserData['name'],
        'SenderProfession':UserData['role'],
      });
      await FirebaseFirestore.instance
          .collection('Chats')
          .doc(user!.uid)
          .collection('Messages')
          .add({
        'message': _messageController.text.trim(),
        'sender': user!.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    } else {
      showErrorSnackbar('Please type a message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(title: 'Chat', color: Colors.white),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Chats')
                  .doc(user!.uid)
                  .collection('Messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var messageData = messages[index].data() as Map<String, dynamic>;
                    var isSender = messageData['sender'] == user!.uid;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Align(
                        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                            color: isSender ? Colors.teal.shade300 : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(isSender ? 12 : 0),
                              topRight: Radius.circular(isSender ? 0 : 12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              )
                            ],
                          ),
                          child: Text(
                            messageData['message'],
                            style: TextStyle(
                              color: isSender ? Colors.white : Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 24,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

