// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pet_owner/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';

final authControllerProvider = Provider(((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthController(ref: ref, authRepository: authRepository);
}));

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final ProviderRef ref;
  final AuthRepository authRepository;
  AuthController({
    required this.ref,
    required this.authRepository,
  });

  Stream<UserModel> userDataById(String userId) {
    return authRepository.userData(userId);
  }

  Future<User?> signIn(String email, String password) async {
    return authRepository.signIn(email, password);
  }

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signOut() async {
    authRepository.signOut();
  }

  Future<User?> createUser(String name, String email, String password) {
    return authRepository.createUser(name, email, password);
  }

  Future<User?> createVeterinary(String name, String email, String password) {
    return authRepository.createVeterinary(name, email, password);
  }

  void sendEmail(String email) {
    authRepository.sendPasswordEmail(email);
  }
}
