import 'package:nfactorial_cup/data/local_db/token_storage.dart';
import 'package:nfactorial_cup/pages/posts/entity/api/posts_api.dart';
import 'package:nfactorial_cup/pages/posts/use_cases/posts_repository.dart';
import 'package:nfactorial_cup/pages/posts/entity/model/response/post_model.dart';
import 'package:dio/dio.dart';

class PostRepositoryImpl extends PostRepository {
  final PostApi postsApi;
  final TokenStorage tokenStorage;

  PostRepositoryImpl({required this.postsApi, required this.tokenStorage});

  @override
  Future<PostResponse> fetchPosts() async {
    try {
      final result = await postsApi.fetchPosts();
      return PostResponse(posts: result);
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}
