import 'package:nfactorial_cup/pages/posts/entity/model/response/post_model.dart';

abstract class PostRepository {
  Future<PostResponse> fetchPosts();
}
