// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/common/widgets/loader.dart';
import 'package:flutter_pet_owner/features/certificate/controller/certificate_controller.dart';
import 'package:flutter_pet_owner/models/certificate_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/shadow_list.dart';

class CertificateListScreen extends ConsumerWidget {
  static const String routeName = '/certificate-list-page';
  final String recieverUserId;
  const CertificateListScreen({
    Key? key,
    required this.recieverUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetApp'),
      ),
      body: StreamBuilder<List<HealthCertificateModel>>(
        stream: ref
            .watch(certificateControllerProvider)
            .getCertificatesStream(recieverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          var list = snapshot.data;

          return ListView.builder(
            itemCount: list!.length,
            itemBuilder: (BuildContext context, int index) {
              var item = list[index];
              return Container(
                height: 230,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: (index % 2 == 0)
                                  ? Colors.blueGrey[200]
                                  : Colors.orangeAccent[200],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: shadowList,
                            ),
                            margin: const EdgeInsets.only(top: 40),
                          ),
                          Align(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: item.map['breed'] == 'Kedi'
                                ? Image.asset('assets/png/pet_cat2.png')
                                : Image.asset('assets/png/dog-png.png'),
                          )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 65, bottom: 20),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          boxShadow: shadowList,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.map['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21.0,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                (item.map['sex'] == 'Erkek')
                                    ? Icon(
                                        Icons.male_rounded,
                                        color: Colors.grey[500],
                                      )
                                    : Icon(
                                        Icons.female_rounded,
                                        color: Colors.grey[500],
                                      ),
                              ],
                            ),
                            Text(
                              item.map['breed'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500],
                              ),
                            ),
                            Text(
                              item.map['date'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[400],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Aşılar',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                (item.map['vaccination'] == 'Evet')
                                    ? Icon(
                                        Icons.done_rounded,
                                        color: Colors.green[500],
                                      )
                                    : Icon(
                                        Icons.done_rounded,
                                        color: Colors.grey[500],
                                      ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'MikroÇip',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                (item.map['microchip'] == 'Evet')
                                    ? Icon(
                                        Icons.done_rounded,
                                        color: Colors.green[500],
                                      )
                                    : Icon(
                                        Icons.done_rounded,
                                        color: Colors.grey[500],
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
