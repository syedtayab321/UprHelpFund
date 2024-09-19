import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';

class AdminConversationPage extends StatelessWidget {
  final String userId;
  final String UserName;
  final TextEditingController _messageController = TextEditingController();

  // Constructor to receive userId
  AdminConversationPage({required this.userId,required this.UserName});

  @override
  Widget build(BuildContext context) {
    final String adminId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, color: Colors.grey.shade700),
            ),
            SizedBox(width: 10.0),
            TextWidget(title: UserName, color: Colors.white),
          ],
        ),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Additional options like profile details
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Chats')
                    .doc(userId)
                    .collection('Messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var messages = snapshot.data!.docs;

                  return ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var messageData = messages[index].data() as Map<String, dynamic>;
                      final isSentByAdmin = messageData['sender'] == adminId;

                      return Align(
                        alignment: isSentByAdmin
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                          margin: EdgeInsets.symmetric(vertical: 6.0),
                          constraints: BoxConstraints(maxWidth: 250),
                          decoration: BoxDecoration(
                            color: isSentByAdmin ? Colors.teal.shade100 : Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: isSentByAdmin
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                title: messageData['message']!,
                                size: 16.0,
                              ),
                              SizedBox(height: 4.0),
                              TextWidget(
                                title: (messageData['timestamp']! as Timestamp)
                                    .toDate()
                                    .toLocal()
                                    .toString(),
                                size: 12.0,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          prefixIcon: Icon(Icons.emoji_emotions, color: Colors.teal.shade700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.teal),
                    onPressed: () async {
                      String message = _messageController.text.trim();
                      if (message.isNotEmpty) {
                        await FirebaseFirestore.instance
                            .collection('Chats')
                            .doc(userId)
                            .collection('Messages')
                            .add({
                          'message': message,
                          'sender': adminId,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        _messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
