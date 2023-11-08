// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_course/state/comments/models/comment.dart';
import 'package:instagram_clone_course/state/comments/providers/delete_comment_provider.dart';
import 'package:instagram_clone_course/state/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone_course/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_clone_course/views/components/constants/strings.dart';
import 'package:instagram_clone_course/views/components/dialogs/alert_diaglog_model.dart';
import 'package:instagram_clone_course/views/components/dialogs/delete_dialog.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(
        comment.fromUserId,
      ),
    );

    return userInfo.when(
      data: (userInfo) {
        final currentUserId = ref.read(userIdProvider);
        return ListTile(
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  onPressed: () async {
                    final shouldDeleteComment =
                        await displayDeleteDialog(context);
                    if (shouldDeleteComment) {
                      await ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(commentId: comment.id);
                    }
                  },
                  icon: const Icon(Icons.delete),
                )
              : null,
          title: Text(userInfo.displayName),
          subtitle: Text(comment.comment),
        );
      },
      error: (_, __) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool> displayDeleteDialog(BuildContext context) => const DeleteDialog(
        titleOfObjectToDelete: Strings.delete,
      )
          .present(
            context,
          )
          .then(
            (value) => value ?? false,
          );
}
