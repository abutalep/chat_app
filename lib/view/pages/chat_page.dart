import 'package:chat_app/constant/app_colors.dart';
import 'package:chat_app/constant/app_images.dart';
import 'package:chat_app/constant/firebase_collections.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/view/widgets/friend_chat_buble.dart';
import 'package:chat_app/view/widgets/my_chat_buble.dart';
import 'package:chat_app/view/widgets/custom_send_text_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  CollectionReference messages = FirebaseFirestore.instance
      .collection(FireBaseCollections.messagescollection);
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageslist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageslist.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColor.primaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImage.logo, height: 50),
                    const Text(
                      'Chat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: messageslist.length,
                          itemBuilder: (context, index) {
                            return messageslist[index].id == email
                                ? MyChatBuble(message: messageslist[index])
                                : FriendChatBuble(message: messageslist[index]);
                          })),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomSendTextField(
                      controller: controller,
                      hintText: "Send Message",
                      onSubmitted: (data) {
                        if (data.isNotEmpty) {
                          messages.add({
                            'message': data,
                            'createdAt': DateTime.now(),
                            'id': email
                          });
                          controller.clear();
                          _controller.animateTo(0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn);
                        }
                      },
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          messages.add({
                            'message': controller.text,
                            'createdAt': DateTime.now(),
                            'id': email
                          });
                          controller.clear();
                          _controller.animateTo(0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn);
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: Text('No messages yet.')),
            );
          }
        });
  }
}
