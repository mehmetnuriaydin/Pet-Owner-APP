import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/common/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/chat_controller.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  const BottomChatField({
    Key? key,
    required this.recieverUserId,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  FocusNode focusNode = FocusNode();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void sendTextMessage() async {
    ref.read(chatControllerProvider).sendTextMessage(
          context,
          _messageController.text.trim(),
          widget.recieverUserId,
        );
    setState(() {
      _messageController.text = '';
    });
  }

  @override
  void initState() {
    super.initState();
    sendTextMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 2, bottom: 4),
                child: TextField(
                  focusNode: focusNode,
                  controller: _messageController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    } else {
                      setState(() {
                        isShowSendButton = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: appBarBgColor,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                    ),
                    hintText: 'Mesaj yazın...',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 2,
                left: 2,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: appBarBgColor,
                  child: InkWell(
                    onTap: () => sendTextMessage(),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
