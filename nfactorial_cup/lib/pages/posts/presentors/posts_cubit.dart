import 'package:nfactorial_cup/pages/posts/presentors/posts_state.dart';
import 'package:nfactorial_cup/pages/posts/use_cases/posts_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  // Статические методы для прослушивания и получения кубита
  static PostState watchState(BuildContext context) =>
      context.watch<PostCubit>().state;
  static PostCubit read(BuildContext context) => context.read<PostCubit>();

  PostCubit({required PostRepository repository})
      : _repository = repository,
        super(PostState(
            posts: [],
            status: InitPostStatus(),
            subPosts: [],
            subPostsStatus: InitPostStatus()));

  final PostRepository _repository;

  void fetchPosts() async {
    try {
      emit(state.copyWith(status: LoadingPostStatus()));
      final posts = await _repository.fetchPosts();
      emit(state.copyWith(posts: posts.posts, status: OkPostStatus()));
    } on DioException catch (e) {
      print(e);
    }
  }

  void fetchSubPosts() async {
    try {
      emit(state.copyWith(subPostsStatus: LoadingPostStatus()));
      final posts = await _repository.fetchPosts();
      emit(state.copyWith(
          subPostsStatus: OkPostStatus(), subPosts: posts.posts));
    } on DioException catch (e) {
      print(e);
    }
  }
}
