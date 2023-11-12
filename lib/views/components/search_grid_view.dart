import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/posts/providers/posts_by_search_term_provider.dart';
import 'package:instagram_clone_course/views/components/animations/data_not_found_view.dart';
import 'package:instagram_clone_course/views/components/animations/empty_contents_with_text_animiation_view.dart';
import 'package:instagram_clone_course/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_course/views/components/post/post_sliver_grid_view.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;

  const SearchGridView({super.key, required this.searchTerm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentsWithTextAnimationView(
          text: Strings.enterYourSearchTerm,
        ),
      );
    }

    final posts = ref.watch(
      postBySearchTermProvider(searchTerm),
    );

    return posts.when(
      data: (posts) {
        return posts.isEmpty
            ? const SliverToBoxAdapter(
                child: DataNotFoundAnimationView(),
              )
            : PostsSliverGridView(posts: posts);
      },
      error: (error, stackTrace) => const SliverToBoxAdapter(
        child: ErrorAnimationView(),
      ),
      loading: () => const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
