import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/common/utils/colors.dart';
import 'package:flutter_pet_owner/common/widgets/loader.dart';
import 'package:flutter_pet_owner/features/certificate/controller/certificate_controller.dart';
import 'package:flutter_pet_owner/features/certificate/screens/certificate_screen.dart';
import 'package:flutter_pet_owner/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectVeterinaryScreen extends ConsumerWidget {
  static const String routeName = '/select-veterinary';
  const SelectVeterinaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lütfen bir veteriner seçin'),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: ref
            .watch(certificateControllerProvider)
            .getVeterinaryList(context)
            .asStream(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var user = snapshot.data![index];
              return Card(
                color: bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  onTap: () => Navigator.pushNamed(
                      context, CertificateScreen.routeName,
                      arguments: {'recieverUserId': user.uid}),
                  title: Text(user.userName!.trim()),
                  leading: CircleAvatar(
                      backgroundColor: appBarBgColor,
                      child: Text(user.userName!.trim().characters.first)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
