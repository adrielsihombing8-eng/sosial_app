import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sosial_app/app/model/postModel.dart';
import 'package:sosial_app/app/services/api.dart';
import 'package:sosial_app/app/services/auth_store.dart';

class FeedController extends GetxController {
  var posts = <Postmodel>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  String? nextCursor;

  final Set<String> viewedInSession = {};

  Future<void> loadMorePosts() async {
    if (isLoading.value || !hasMore.value) return;
    
    isLoading.value = true;
    final response = await Api.getPosts(cursor: nextCursor);
    
    posts.addAll(response.posts);
    nextCursor = response.nextCursor;
    hasMore.value = response.hasMore;
    
    isLoading.value = false;
  }

  Future<void> refreshPosts() async {
    posts.clear();
    nextCursor = null;
    hasMore.value = true;
    await loadMorePosts();
  }

  void markAsViewed(String postId) {
    if (viewedInSession.contains(postId)) return;
    viewedInSession.add(postId);
    sendView(postId);
  }

  Future<void> sendView(String postId) async {
    try {
      final token = await AuthStore.getToken();
      if (token == null) return;
      await Api.addPostView(postId, token);
    } catch (err) {
      viewedInSession.remove(postId);
    }
  }
}