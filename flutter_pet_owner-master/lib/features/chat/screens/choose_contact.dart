import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/features/chat/controller/chat_controller.dart';
import 'package:flutter_pet_owner/features/chat/screens/mobile_chat_screen.dart';
import 'package:flutter_pet_owner/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseContactPage extends ConsumerStatefulWidget {
  static const String routeName = '/choose-contact-page';
  const ChooseContactPage({super.key});

  @override
  ConsumerState<ChooseContactPage> createState() => _ChooseContactPageState();
}

class _ChooseContactPageState extends ConsumerState<ChooseContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<UserModel>>(
        stream: ref
            .watch(chatControllerProvider)
            .getVeterinaryContacts(context)
            .asStream(),
        builder: (BuildContext context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              var user = snapshot.data?[index];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, MobileChatScreen.routeName,
                        arguments: {
                          'name': user?.userName,
                          'uid': user!.uid,
                        });
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('${user?.userName![0].toUpperCase()}'),
                  ),
                  title: Text('${user?.userName}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
