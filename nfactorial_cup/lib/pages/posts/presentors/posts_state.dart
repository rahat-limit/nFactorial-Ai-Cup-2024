import 'package:nfactorial_cup/pages/posts/entity/model/response/post_model.dart';

class PostState {
  final List<PostModel> posts;
  final List<PostModel> subPosts;
  final PostStatus status;
  final PostStatus subPostsStatus;
  const PostState(
      {required this.posts,
      required this.status,
      required this.subPosts,
      required this.subPostsStatus});

  PostState copyWith(
      {List<PostModel>? posts,
      PostStatus? status,
      List<PostModel>? subPosts,
      PostStatus? subPostsStatus}) {
    return PostState(
        posts: posts ?? this.posts,
        status: status ?? this.status,
        subPosts: subPosts ?? this.subPosts,
        subPostsStatus: subPostsStatus ?? this.subPostsStatus);
  }
}

abstract class PostStatus {}

class InitPostStatus extends PostStatus {}

class OkPostStatus extends PostStatus {}

class LoadingPostStatus extends PostStatus {}

class ErrorPostStatus extends PostStatus {}
