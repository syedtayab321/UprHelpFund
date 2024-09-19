import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upr_fund_collection/CustomWidgets/TextWidget.dart';
import 'package:upr_fund_collection/Portals/AdminPortal/DashboardComponents/AdminConversationPage.dart';

class AdminMessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade700, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Chats').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            // Get the list of document IDs
            final List<DocumentSnapshot> chatDocuments = snapshot.data!.docs;

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: chatDocuments.length,
              itemBuilder: (context, index) {
                // Get the document ID, which is the user's UID
                final String userId = chatDocuments[index].id;
                final Map<String, dynamic> data = chatDocuments[index].data() as Map<String, dynamic>;
                final String userName = data['SenderName'] ?? 'Default User';
                final String userProfession = data['SenderProfession'] ?? 'Default User';
                return InkWell(
                  onTap: () {
                    Get.to(AdminConversationPage(userId: userId,UserName: userName,));
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      tileColor: Colors.white,
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade700,
                        child: TextWidget(
                          title: userId[0], // Initials of the user ID
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      title: TextWidget(
                        title: userName,
                        weight: FontWeight.bold,
                        size: 18,
                        color: Colors.teal.shade700,
                      ),
                      subtitle:TextWidget(
                        title: userProfession,

                      ) ,
                      trailing: Icon(
                        Icons.message_outlined,
                        color: Colors.teal.shade700,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
