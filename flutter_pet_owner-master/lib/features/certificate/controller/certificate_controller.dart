// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/features/auth/controller/auth_controller.dart';
import 'package:flutter_pet_owner/features/certificate/repository/certificate_repository.dart';
import 'package:flutter_pet_owner/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/certificate_model.dart';

final certificateControllerProvider = Provider((ref) {
  final certificateRepository = ref.watch(certificateRepositoryProvider);
  return CertificateController(
      certificateRepository: certificateRepository, ref: ref);
});

class CertificateController {
  final CertificateRepository certificateRepository;
  final ProviderRef ref;
  CertificateController({
    required this.certificateRepository,
    required this.ref,
  });

  Future<List<UserModel>> getVeterinaryList(context) {
    return certificateRepository.getVeterinary(context);
  }

  Stream<List<HealthCertificateModel>> getCertificatesStream(
      String recieverUserId) {
    return certificateRepository.getCertificatesStream(recieverUserId);
  }

  void createCertificate(
    BuildContext context,
    String recieverUserId,
    Map<String, dynamic> map,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => certificateRepository.createCertificate(
              context: context,
              recieverUserId: recieverUserId,
              senderUser: value!,
              map: map),
        );
  }
}
