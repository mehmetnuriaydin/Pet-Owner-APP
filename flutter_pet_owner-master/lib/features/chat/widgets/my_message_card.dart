import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/common/utils/colors.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final String username;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: message.isNotEmpty
            ? Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: appBarBgColor,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 30,
                        top: 5,
                        bottom: 20,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              message,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 10,
                      child: FittedBox(
                        child: Text(
                          date,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
