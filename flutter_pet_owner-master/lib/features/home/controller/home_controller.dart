// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_pet_owner/features/home/repository/home_repository.dart';
import 'package:flutter_pet_owner/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/blog_model.dart';

final homeControllerProvider = Provider((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return HomeController(homeRepository: homeRepository, ref: ref);
});

class HomeController {
  final HomeRepository homeRepository;
  final ProviderRef ref;
  HomeController({
    required this.homeRepository,
    required this.ref,
  });

  Future<List<UserModel>> getUids() {
    return homeRepository.getUsers();
  }

  Stream<List<BlogModel>> getBlogList() {
    return homeRepository.getBlogList();
  }

  Stream<List<BlogModel>> getVeterinaryBlogList() {
    return homeRepository.getVeterinaryBlogList();
  }
}
