import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sosial_app/app/model/authModel.dart';
import 'package:sosial_app/app/model/postModel.dart';
import 'package:sosial_app/app/services/api.dart';
import 'package:sosial_app/app/services/auth_store.dart';

class Postcard extends StatefulWidget {
  final Authmodel user;
  final Postmodel post;
  const Postcard({required this.user, required this.post, super.key});

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  late Authmodel user;

  @override
  void initState() {
    //loadUser();
    super.initState();
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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        widget.user.username ?? '', //user.username
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat(
                          'dd MMM yyyy, HH:mm',
                        ).format(widget.post.date ?? DateTime.now()),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
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
                  style: const TextStyle(fontSize: 14),
                ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
