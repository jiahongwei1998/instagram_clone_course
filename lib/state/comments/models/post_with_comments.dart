import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_course/state/comments/models/comment.dart';
import 'package:instagram_clone_course/state/posts/models/post.dart';

@immutable
class PostWithComments {
  final Post post;
  final Iterable<Comment> comemnts;

  const PostWithComments({required this.post, required this.comemnts});

  @override
  operator ==(covariant PostWithComments other) =>
      identical(this, other) ||
      post == other.post &&
          const IterableEquality().equals(
            comemnts,
            other.comemnts,
          );

  @override
  int get hashCode => Object.hashAll([post, comemnts]);
}
