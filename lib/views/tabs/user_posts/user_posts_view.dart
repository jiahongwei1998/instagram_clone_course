import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/posts/providers/user_posts_provider.dart';
import 'package:instagram_clone_course/views/compoents/animations/empty_contents_with_text_animiation_view.dart';
import 'package:instagram_clone_course/views/compoents/animations/error_animation_view.dart';
import 'package:instagram_clone_course/views/compoents/animations/loading_animation_view.dart';
import 'package:instagram_clone_course/views/compoents/post/post_gird_view.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        final _ = ref.refresh(userPostsProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: posts.when(data: (posts) {
        if (posts.isEmpty) {
          return const EmptyContentsWithTextAnimationView(
            text: Strings.youHaveNoPosts,
          );
        } else {
          return PostsGridView(posts: posts);
        }
      }, error: (error, stackTrace) {
        return const ErrorAnimationView();
      }, loading: () {
        return const LoadingAnimationView();
      }),
    );
  }
}
