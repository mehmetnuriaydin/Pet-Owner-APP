import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/SSS_page.dart';
import 'package:flutter_pet_owner/features/auth/controller/auth_controller.dart';
import 'package:flutter_pet_owner/features/hakkimizda_page.dart';
import 'package:flutter_pet_owner/features/maps/map_open.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/colors.dart';
import '../../../common/widgets/loader.dart';
import '../../../models/user_model.dart';
import '../../chat/screens/message_list_screen.dart';
import '../../onboard_page.dart';

class WidgetDrawer extends ConsumerWidget {
  const WidgetDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: FutureBuilder<UserModel?>(
          future: ref.watch(authControllerProvider).getUserData(),
          builder: (context, snapshot) {
            var user = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            return user!.veterinary == false ? UserListView(user: user) : VeterinaryListView(user: user);
          }),
    );
  }
}

class UserListView extends ConsumerWidget {
  const UserListView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        DrawerHeader(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          child: Container(
            color: colorBlue,
            child: Container(
              margin: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: bgColor,
                    child: Text(user!.userName!.trim().characters.first),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    child: Text(user!.userName!.trim()),
                  )
                ],
              ),
            ),
          ),
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, MessageListScreen.routeName),
          title: const Text('Mesajlar'),
        ),
        const Divider(),
        ListTile(
          onTap: () => showDialog(
              context: context,
              builder: (context) {
                return Container(
                  child: AlertDialog(
                    title: Text('Çok Yakında'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Kapat'))
                    ],
                  ),
                );
              }),
          title: Text('Puan Ver'),
        ),
        const Divider(),
        ListTile(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => MapOpen()))),
          title: const Text('Veterinerler Konum'),
        ),
        const Divider(),
        ListTile(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => HakkimizdaPage()))),
          title: Text('Hakkımızda'),
        ),
        const Divider(),
        ListTile(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => SSSPage()))),
          title: Text('SSS'),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            ref.read(authControllerProvider).signOut();
            Navigator.pushNamedAndRemoveUntil(context, OnboardPage.routeName, (route) => false);
          },
          title: const Text('Çıkış Yap'),
        ),
      ],
    );
  }
}

class VeterinaryListView extends ConsumerWidget {
  const VeterinaryListView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        DrawerHeader(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          child: Container(
            color: appBarBgColor,
            child: Container(
              margin: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: bgColor,
                    child: Text(user!.userName!.trim().characters.first),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    child: Text(user!.userName!.trim()),
                  )
                ],
              ),
            ),
          ),
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, MessageListScreen.routeName),
          title: const Text('Mesajlar'),
        ),
        const Divider(),
        ListTile(
          onTap: () => showDialog(
              context: context,
              builder: (context) {
                return Container(
                  child: AlertDialog(
                    title: Text('Çok Yakında'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Kapat'))
                    ],
                  ),
                );
              }),
          title: Text('Puan Ver'),
        ),
        const Divider(),
        ListTile(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => HakkimizdaPage()))),
          title: Text('hakkımızda'),
        ),
        const Divider(),
        ListTile(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => SSSPage()))),
          title: Text('SSS'),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            ref.read(authControllerProvider).signOut();
            Navigator.pushNamedAndRemoveUntil(context, OnboardPage.routeName, (route) => false);
          },
          title: const Text('Çıkış Yap'),
        ),
      ],
    );
  }
}
