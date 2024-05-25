import 'package:nfactorial_cup/pages/posts/entity/model/response/post_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'posts_api.g.dart';

@RestApi()
abstract class PostApi {
  factory PostApi(Dio dio) = _PostApi;

  @GET('/posts')
  Future<List<PostModel>> fetchPosts();
}
