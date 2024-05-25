import 'package:auto_route/auto_route.dart';
import 'package:nfactorial_cup/pages/posts/presentors/posts_cubit.dart';
import 'package:nfactorial_cup/pages/posts/presentors/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
    PostCubit.read(context).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              PostCubit.read(context).fetchSubPosts();
              // context.changeLocale('ru');
            },
            child: const Icon(Icons.add)),
        appBar: AppBar(title: Text('posts')),
        body: Column(
          children: [
            SizedBox(
                width: double.infinity,
                height: 400,
                child: BlocBuilder<PostCubit, PostState>(
                    builder: (context, state) {
                  switch (state.status) {
                    case InitPostStatus():
                      return const SizedBox();
                    case LoadingPostStatus():
                      return const Center(child: CircularProgressIndicator());
                    case OkPostStatus():
                      return SingleChildScrollView(
                        child: Column(
                            children: state.posts
                                .map((e) =>
                                    ListTile(title: Text('Posts: ${e.title}')))
                                .toList()),
                      );
                    default:
                      return const SizedBox();
                  }
                })),
            Expanded(child:
                BlocBuilder<PostCubit, PostState>(builder: (context, state) {
              switch (state.subPostsStatus) {
                case InitPostStatus():
                  return const SizedBox();
                case LoadingPostStatus():
                  return const Center(child: CircularProgressIndicator());
                case OkPostStatus():
                  return SingleChildScrollView(
                    child: Column(
                        children: state.subPosts
                            .map((e) =>
                                ListTile(title: Text('SubPosts: ${e.title}')))
                            .toList()),
                  );
                default:
                  return const SizedBox();
              }
            }))
          ],
        ));
  }
}
