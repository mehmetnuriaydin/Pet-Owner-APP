import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/chat_contact_model.dart';
import '../../../models/message_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/chat_repository.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<MessageModel>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
              context: context,
              text: text,
              recieverUserId: recieverUserId,
              senderUser: value!),
        );
  }

  Stream<List<ChatContactModel>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  Future<List<UserModel>> getVeterinaryContacts(context) {
    return chatRepository.getVeterinary(context);
  }
}
