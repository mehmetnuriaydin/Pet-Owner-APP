import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/features/auth/screens/send_password_email.dart';
import 'package:flutter_pet_owner/features/certificate/screens/certificate_list_screen.dart';
import 'package:flutter_pet_owner/features/certificate/screens/certificate_screen.dart';
import 'package:flutter_pet_owner/features/certificate/screens/select_veterinary_screen.dart';
import 'package:flutter_pet_owner/features/certificate/screens/select_veterinary_screen_for_user.dart';
import 'package:flutter_pet_owner/features/chat/screens/choose_contact.dart';
import 'package:flutter_pet_owner/features/chat/screens/message_list_screen.dart';
import 'package:flutter_pet_owner/features/home/screens/home_page.dart';
import 'package:flutter_pet_owner/features/onboard_page.dart';

import 'common/widgets/error.dart';
import 'features/chat/screens/mobile_chat_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];

      return MaterialPageRoute(
        builder: ((context) => MobileChatScreen(
              name: name,
              uid: uid,
            )),
      );
    case CertificateListScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final recieverUserId = arguments['recieverUserId'];
      return MaterialPageRoute(
          builder: ((context) =>
              CertificateListScreen(recieverUserId: recieverUserId)));
    case MessageListScreen.routeName:
      return MaterialPageRoute(
        builder: ((context) => const MessageListScreen()),
      );
    case HomePage.routeName:
      return MaterialPageRoute(
        builder: ((context) => const HomePage()),
      );
    case SelectVeterinaryScreen.routeName:
      return MaterialPageRoute(
        builder: ((context) => const SelectVeterinaryScreen()),
      );
    case SendPasswordEmail.routeName:
      return MaterialPageRoute(
        builder: ((context) => const SendPasswordEmail()),
      );
    case SelectVeterinaryScreenForUser.routeName:
      return MaterialPageRoute(
        builder: ((context) => const SelectVeterinaryScreenForUser()),
      );
    case CertificateScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final recieverUserId = arguments['recieverUserId'];
      return MaterialPageRoute(
        builder: ((context) => CertificateScreen(
              recieverUserId: recieverUserId,
            )),
      );
    case OnboardPage.routeName:
      return MaterialPageRoute(
        builder: ((context) => const OnboardPage()),
      );
    case ChooseContactPage.routeName:
      return MaterialPageRoute(
        builder: ((context) => const ChooseContactPage()),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "Something wrong. This page doesn't exist"),
        ),
      );
  }
}
