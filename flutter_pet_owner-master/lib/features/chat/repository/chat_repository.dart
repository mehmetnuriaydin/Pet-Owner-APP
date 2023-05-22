import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../common/utils/utils.dart';
import '../../../models/chat_contact_model.dart';
import '../../../models/message_model.dart';
import '../../../models/user_model.dart';

final chatRepositoryProvider = Provider(((ref) => ChatRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance)));

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  ChatRepository({
    required this.auth,
    required this.firestore,
  });

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUser,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel? recieverUserData;

      var userDataMap =
          await firestore.collection('users').doc(recieverUserId).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);

      var messageId = const Uuid().v4();

      _saveDataToContactsSubCollection(
          senderUser, recieverUserData, text, timeSent, recieverUserId);

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        recieverUsername: recieverUserData.userName,
        username: senderUser.userName!,
        senderUsername: senderUser.userName!,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Stream<List<MessageModel>> getChatStream(String recieverUserId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var document in event.docs) {
        messages.add(
          MessageModel.fromMap(
            document.data(),
          ),
        );
      }
      return messages;
    });
  }

  void _saveMessageToMessageSubcollection({
    required String recieverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required String? recieverUsername,
    required String senderUsername,
  }) async {
    final message = MessageModel(
      senderId: auth.currentUser!.uid,
      recieverId: recieverUserId,
      text: text,
      timeSent: timeSent,
      messageId: messageId,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());

    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  Future<List<UserModel>> getVeterinary(BuildContext context) async {
    List<UserModel> contacts = [];
    try {
      var usersData = await firestore
          .collection('users')
          .where('veterinary', isEqualTo: true)
          .get();

      for (var document in usersData.docs) {
        var user = UserModel.fromMap(document.data());
        contacts.add(user);
      }
      return contacts;
    } catch (e) {
      return contacts;
    }
  }

  Future<bool> getCurrentUserState() async {
    var currentUser =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();
    var currentUserData = UserModel.fromMap(currentUser.data()!);
    if (currentUserData.veterinary!) {
      return true;
    } else {
      return false;
    }
  }

  Stream<List<ChatContactModel>> getChatContacts() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContactModel> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContactModel.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);

        contacts.add(ChatContactModel(
          name: user.userName!,
          contactId: chatContact.contactId,
          timeSent: chatContact.timeSent,
        ));
      }
      return contacts;
    });
  }

  void _saveDataToContactsSubCollection(
    UserModel senderUserData,
    UserModel? recieverUserData,
    String text,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    var recieverChatContact = ChatContactModel(
      name: senderUserData.userName!,
      contactId: senderUserData.uid!,
      timeSent: timeSent,
    );
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());

    var senderChatContact = ChatContactModel(
      name: recieverUserData!.userName!,
      contactId: recieverUserData.uid!,
      timeSent: timeSent,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .set(senderChatContact.toMap());
  }
}
