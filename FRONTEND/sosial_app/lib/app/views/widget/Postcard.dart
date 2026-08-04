import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:sosial_app/app/model/authModel.dart';
import 'package:sosial_app/app/model/postModel.dart';
import 'package:sosial_app/app/services/api.dart';
import 'package:sosial_app/app/services/auth_store.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Postcard extends StatefulWidget {
  final Postmodel post;
  const Postcard({required this.post, super.key});

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  late Authmodel user;
  bool hasCountedView = false;

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    final visiblePercentage = info.visibleFraction * 100;

    if (visiblePercentage > 60 && !hasCountedView) {
      hasCountedView = true;
      sendView();
    }
  }

  void sendView() async {
    try {
      final token = await AuthStore.getToken();
      if (token == null) return;

      await Api.addPostView(widget.post.id!, token);
    } catch (err) {
      if (err.toString().contains("SESSION_EXPIRED")) {
        if (mounted) Get.toNamed('/LOGIN');
      }
      
      hasCountedView = false;
    }
  }

  void loadUser() async {
    var token = await AuthStore.getToken();
    if (token == null) {
      if (mounted) {
        Get.toNamed('/LOGIN');
      }
      return;
    }

    if (mounted) {
      try {
        user = await Api.userData(widget.post.userId!, token);
      } catch (err) {
        if (err.toString().contains("SESSION_EXPIRED")) {
          Get.toNamed('/LOGIN');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('post-${widget.post.id}'),
      onVisibilityChanged: (info) {
        _onVisibilityChanged(info);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF07050F), Colors.black ,Color(0xFF07050F), Color(0xFF0F0B1E)],
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
          ),
        ),
        child: Card(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: CircleAvatar(child: Icon(Icons.person_rounded)),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.username ?? '', //user.username
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            Text(
                              DateFormat(
                                'dd MMM yyyy, HH:mm',
                              ).format(widget.post.date ?? DateTime.now()),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 35,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 20),
                        child: Text(
                          "Follow",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                if (widget.post.imageUrl != null) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.post.imageUrl!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(
                            height: 200,
                            child: Center(child: Icon(Icons.broken_image)),
                          ),
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const SizedBox(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                ],
                if (widget.post.content != null)
                  Text(
                    widget.post.content!,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.heart, color: Colors.white,),
                        ),
                        Text("20", style: TextStyle(color: Colors.white),),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.chat_bubble, color: Colors.white,),
                        ),
                        Text("20", style: TextStyle(color: Colors.white)),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.arrow_2_squarepath, color: Colors.white,),
                        ),
                        Text("20", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.bookmark, color: Colors.white,),
                        ),
                        Text("20", style: TextStyle(color: Colors.white)),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.share_up, color: Colors.white,),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
