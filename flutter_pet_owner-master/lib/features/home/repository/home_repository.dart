// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pet_owner/models/blog_model.dart';
import 'package:flutter_pet_owner/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider((ref) => HomeRepository(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class HomeRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  HomeRepository({
    required this.firestore,
    required this.auth,
  });

  Future<List<UserModel>> getUsers() async {
    return await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) async {
      List<UserModel> userModels = [];
      for (var patientUid in value.get('patientList')) {
        var user = await userData(patientUid);
        userModels.add(user);
      }
      return userModels;
    });
  }

  Future<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).get().then(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  Stream<List<BlogModel>> getBlogList() {
    return firestore.collection('blogs').snapshots().asyncMap((event) {
      List<BlogModel> list = [];
      for (var element in event.docs) {
        var blog = BlogModel.fromMap(element.data());
        list.add(blog);
      }
      return list;
    });
  }
    Stream<List<BlogModel>> getVeterinaryBlogList() {
    return firestore.collection('veterinaryBlog').snapshots().asyncMap((event) {
      List<BlogModel> list = [];
      for (var element in event.docs) {
        var blog = BlogModel.fromMap(element.data());
        list.add(blog);
      }
      return list;
    });
  }
}
