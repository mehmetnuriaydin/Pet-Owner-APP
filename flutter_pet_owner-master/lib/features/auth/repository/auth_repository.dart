import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';

final authRepositoryProvider = Provider(((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance)));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });
  Future<User?> signIn(String email, String password) async {
    var user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await auth.signOut();
  }

  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  Future<User?> createUser(String name, String email, String password) async {
    var user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await firestore.collection("users").doc(user.user!.uid).set({
      'uid': user.user!.uid,
      'userName': name,
      'email': email,
      'veterinary': false,
    });
    return user.user;
  }

  Future<User?> createVeterinary(
      String name, String email, String password) async {
    var user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await firestore.collection("users").doc(user.user!.uid).set({
      'uid': user.user!.uid,
      'userName': name,
      'email': email,
      'veterinary': true,
      'patientList': [],
    });
    return user.user;
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;

    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  void sendPasswordEmail(String email) {
    auth.sendPasswordResetEmail(email: email);
  }
}
