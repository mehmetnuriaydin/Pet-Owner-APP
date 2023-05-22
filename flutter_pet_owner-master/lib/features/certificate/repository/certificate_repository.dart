// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/common/utils/utils.dart';
import 'package:flutter_pet_owner/models/certificate_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../models/chat_contact_model.dart';
import '../../../models/user_model.dart';

final certificateRepositoryProvider = Provider((ref) => CertificateRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class CertificateRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  CertificateRepository({
    required this.auth,
    required this.firestore,
  });

  Future<List<UserModel>> getVeterinary(BuildContext context) async {
    List<UserModel> contacts = [];
    try {
      var usersData = await firestore
          .collection('users')
          .where('veterinary', isEqualTo: true)
          .get();

      for (var document in usersData.docs) {
        var user = UserModel.fromMap(document.data());
        contacts.add(user);
      }
      return contacts;
    } catch (e) {
      return contacts;
    }
  }

  void createCertificate({
    required BuildContext context,
    required String recieverUserId,
    required UserModel senderUser,
    required Map<String, dynamic> map,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel? recieverUserData;
      var userDataMap =
          await firestore.collection('users').doc(recieverUserId).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);

      var certificateId = const Uuid().v4();
      List patientList = [];
      patientList.add(senderUser.uid);
      await firestore
          .collection('users')
          .doc(recieverUserData.uid)
          .update({'patientList': FieldValue.arrayUnion(patientList)});

      _saveDataToVeterinariesSubCollection(
          senderUser, recieverUserData, timeSent, recieverUserId);

      _saveCertificateToCertificatesSubCollection(
          recieverUserId: recieverUserId,
          timeSent: timeSent,
          username: senderUser.userName!,
          certificateId: certificateId,
          recieverUsername: recieverUserData.userName,
          senderUsername: senderUser.userName!,
          map: map);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void _saveCertificateToCertificatesSubCollection(
      {required String recieverUserId,
      required DateTime timeSent,
      required String username,
      required String certificateId,
      required String? recieverUsername,
      required String senderUsername,
      required Map<String, dynamic> map}) async {
    final certificate = HealthCertificateModel(
        senderId: auth.currentUser!.uid,
        recieverId: recieverUserId,
        map: map,
        timeSent: timeSent,
        certificateId: certificateId);

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('certificates')
        .doc(recieverUserId)
        .collection('healthCertificates')
        .doc(certificateId)
        .set(certificate.toMap());

    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('certificates')
        .doc(auth.currentUser!.uid)
        .collection('healthCertificates')
        .doc(certificateId)
        .set(certificate.toMap());
  }

  void _saveDataToVeterinariesSubCollection(
    UserModel senderUserData,
    UserModel? recieverUserData,
    DateTime timeSent,
    String recieverUserId,
  ) async {
    var recieverChatContact = ChatContactModel(
      name: senderUserData.userName!,
      contactId: senderUserData.uid!,
      timeSent: timeSent,
    );
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection('certificates')
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());

    var senderChatContact = ChatContactModel(
      name: recieverUserData!.userName!,
      contactId: recieverUserData.uid!,
      timeSent: timeSent,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('certificates')
        .doc(recieverUserId)
        .set(senderChatContact.toMap());
  }

  Stream<List<HealthCertificateModel>> getCertificatesStream(
      String recieverUserId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('certificates')
        .doc(recieverUserId)
        .collection('healthCertificates')
        .snapshots()
        .asyncMap((event) async {
      List<HealthCertificateModel> certificates = [];
      for (var document in event.docs) {
        var certificateModel = HealthCertificateModel.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(certificateModel.recieverId)
            .collection('certificates')
            .doc(certificateModel.senderId)
            .collection('healthCertificates')
            .doc(certificateModel.certificateId)
            .get();
        var user = HealthCertificateModel.fromMap(userData.data()!);

        certificates.add(HealthCertificateModel(
            senderId: user.senderId,
            recieverId: user.recieverId,
            map: user.map,
            timeSent: user.timeSent,
            certificateId: user.certificateId));
      }
      return certificates;
    });
  }
}
