import 'package:sosial_app/app/model/postModel.dart';

class Postservices {
  final List<Postmodel> posts;
  final String? nextCursor;
  final bool hasMore;

  Postservices({
    required this.posts,
    required this.nextCursor,
    required this.hasMore,
  });

  factory Postservices.fromJson(Map<String, dynamic> json) {
    return Postservices(
      posts: (json['posts'] as List)
          .map((e) => Postmodel.fromJson(e))
          .toList(),
      nextCursor: json['nextCursor'],
      hasMore: json['hasMore'] ?? false,
    );
  }
}