// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_course/state/comments/models/post_comments_request.dart';
import 'package:instagram_clone_course/state/comments/providers/post_comments_provider.dart';
import 'package:instagram_clone_course/state/comments/providers/send_comment_provider.dart';
import 'package:instagram_clone_course/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';
import 'package:instagram_clone_course/views/extensions/dismiss_keyboard.dart';

class PostCommentsView extends HookConsumerWidget {
  final PostId postId;

  const PostCommentsView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();

    final hasText = useState(false);
    final request = useState(
      RequestForPostAndComments(postId: postId),
    );
    final comments = ref.watch(postCommentsProvider(request.value));

    useEffect(
      () {
        commentController.addListener(() {
          hasText.value = commentController.text.isNotEmpty;
        });
        return () {};
      },
      [commentController],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.comments,
        ),
        actions: [
          IconButton(
              onPressed: hasText.value
                  ? () {
                      _submitCommentWithController(
                        commentController,
                        ref,
                      );
                    }
                  : null,
              icon: const Icon(Icons.send))
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
    TextEditingController controller,
    WidgetRef ref,
  ) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
          fromUserId: userId,
          onPostId: postId,
          comment: controller.text,
        );
    if (isSent) {
      controller.clear();
      dissmissKeyboard();
    }
  }
}
