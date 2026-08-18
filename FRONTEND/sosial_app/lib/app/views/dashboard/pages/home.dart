import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sosial_app/app/controller/feed_controller.dart';
import 'package:sosial_app/app/model/authModel.dart';
import 'package:sosial_app/app/model/postModel.dart';
import 'package:sosial_app/app/views/widget/Postcard.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FeedController controller = Get.find<FeedController>();
  final ScrollController scrollController = ScrollController();
  // final Authmodel user = Authmodel(
  //   id: '11111',
  //   username: 'Adriel Sihombing',
  //   email: 'adrielsihombing@gmail.com',
  // );

  // final Postmodel post = Postmodel(
  //   id: '1111',
  //   userId: '2222',
  //   content: 'content',
  //   imageUrl: null,
  //   date: DateTime(2026, 7, 31, 14, 30, 0),
  //   like: false,
  //   save: false,
  // );

    @override
  void initState() {
    super.initState();
    controller.loadMorePosts(); 

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller.loadMorePosts();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F0B1E), Color(0xFF07050F)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.book, size: 20, color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text("CoLite", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border_outlined, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Obx(() {
        if (controller.posts.isEmpty && controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.refreshPosts,
          child: ListView.builder(
            controller:scrollController,
            itemCount: controller.posts.length + (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= controller.posts.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final post = controller.posts[index];
              return VisibilityDetector(
            key: Key('post-${post.id}'),
            onVisibilityChanged: (info) {
              
              if (info.visibleFraction >= 0.5) {
                controller.onPostVisible(post.id);
              } else {
                controller.onPostHidden(post.id);
              }
            },
            child: Postcard(post: post),
          );
            },
          ),
        );
      }),
      ),
    );
  }
}
