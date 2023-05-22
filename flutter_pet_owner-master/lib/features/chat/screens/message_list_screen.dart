import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/common/widgets/loader.dart';
import 'package:flutter_pet_owner/features/chat/screens/choose_contact.dart';
import 'package:flutter_pet_owner/features/chat/widgets/contact_list.dart';
import 'package:flutter_pet_owner/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controller/auth_controller.dart';

class MessageListScreen extends ConsumerWidget {
  static const String routeName = '/message-list-page';
  const MessageListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<UserModel?>(
        future: ref.watch(authControllerProvider).getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          var user = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mesajlar'),
              actions: [
                user.veterinary == true
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () => Navigator.pushNamed(
                            context, ChooseContactPage.routeName),
                        icon: const Icon(Icons.message_rounded),
                      )
              ],
            ),
            body: const ContactsList(),
          );
        });
  }
}
