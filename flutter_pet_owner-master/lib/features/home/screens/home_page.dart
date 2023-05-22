import 'package:flutter/material.dart';
import 'package:flutter_pet_owner/common/utils/colors.dart';
import 'package:flutter_pet_owner/common/widgets/loader.dart';
import 'package:flutter_pet_owner/features/auth/controller/auth_controller.dart';
import 'package:flutter_pet_owner/features/certificate/screens/certificate_list_screen.dart';
import 'package:flutter_pet_owner/features/certificate/screens/select_veterinary_screen_for_user.dart';
import 'package:flutter_pet_owner/features/home/controller/home_controller.dart';
import 'package:flutter_pet_owner/models/blog_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/shadow_list.dart';
import '../../../models/user_model.dart';
import '../../certificate/screens/select_veterinary_screen.dart';
import '../widgets/drawer.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String routeName = '/home-page-screen';
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;
  void signOut() {
    ref.read(authControllerProvider).signOut();
  }

  Future<UserModel?> getCurrentUser() async {
    return await ref.watch(authControllerProvider).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const WidgetDrawer(),
      appBar: AppBar(
        title: const Text('Anasayfa'),
      ),
      body: FutureBuilder<UserModel?>(
          future: ref.watch(authControllerProvider).getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            return snapshot.data!.veterinary == true
                ? Container(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        StreamBuilder<List<UserModel>>(
                          stream: ref.watch(homeControllerProvider).getUids().asStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Loader();
                            }
                            List<UserModel> userList = snapshot.data!;

                            return Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.all(4),
                                      child: Text(
                                        'Karneler',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 15,
                                    child: userList.isEmpty
                                        ? Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Henüz bir karne oluşturulmamış',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19.0,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            physics: const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              var user = userList[index];
                                              return GestureDetector(
                                                onTap: (() {
                                                  Navigator.pushNamed(context, CertificateListScreen.routeName,
                                                      arguments: {'recieverUserId': user.uid});
                                                }),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: 65,
                                                      height: 65,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15), color: usersBgColor),
                                                      margin: const EdgeInsets.all(4),
                                                      child: Text(user.userName!.characters.first),
                                                    ),
                                                    Text(user.userName!),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      margin: const EdgeInsets.all(12),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Blog',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 56,
                                    child: Container(
                                      margin: const EdgeInsets.all(4),
                                      child: StreamBuilder<List<BlogModel>>(
                                        stream: ref.watch(homeControllerProvider).getVeterinaryBlogList(),
                                        builder: (BuildContext context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Loader();
                                          }
                                          if (snapshot.hasData) {
                                            var list = snapshot.data;
                                            return ListView.builder(
                                              physics: const BouncingScrollPhysics(),
                                              itemCount: list!.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                var article = list[index];
                                                return Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                                    decoration: BoxDecoration(
                                                      boxShadow: shadowList,
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Colors.white,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                article.title!,
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 21.0,
                                                                  color: Colors.grey[600],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 2),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  article.content!,
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.grey[400],
                                                                    letterSpacing: 0.8,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                          return Center(
                                            child: Text(
                                              'Henüz bir makale yayınlanmamış.',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 21.0,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Kullanıcı İşlemleri',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 30,
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: GestureDetector(
                                      onTap: () =>
                                          Navigator.pushNamed(context, SelectVeterinaryScreenForUser.routeName),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          image: const DecorationImage(
                                              image: AssetImage('assets/png/list.png'), fit: BoxFit.cover),
                                        ),
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            'Karnelerimi Görüntüle',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21.0,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: GestureDetector(
                                      onTap: () => Navigator.pushNamed(context, SelectVeterinaryScreen.routeName),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          image: const DecorationImage(
                                              image: AssetImage('assets/png/create.png'), fit: BoxFit.cover),
                                        ),
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            'Karne Oluştur',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21.0,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Blog',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 56,
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          child: StreamBuilder<List<BlogModel>>(
                            stream: ref.watch(homeControllerProvider).getBlogList(),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Loader();
                              }
                              if (snapshot.hasData) {
                                var list = snapshot.data;
                                return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: list!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var article = list[index];
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                      decoration: BoxDecoration(
                                        boxShadow: shadowList,
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  article.title!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 21.0,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                FittedBox(
                                                  child: Text(
                                                    article.content!,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[400],
                                                      letterSpacing: 0.8,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Center(
                                child: Text('Henüz bir makale yayınlanmamış.'),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
          }),
    );
  }
}
