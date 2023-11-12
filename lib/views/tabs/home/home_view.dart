import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/providers/all_posts_provider.dart';
import 'package:instagram_clone_course/views/components/animations/empty_contents_with_text_animiation_view.dart';
import 'package:instagram_clone_course/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_course/views/components/post/posts_gird_view.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    return RefreshIndicator(
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: Strings.noPostsAvailable,
            );
          } else {
            return PostsGridView(posts: posts);
          }
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      onRefresh: () {
        final _ = ref.refresh(allPostsProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
    );
  }
}
