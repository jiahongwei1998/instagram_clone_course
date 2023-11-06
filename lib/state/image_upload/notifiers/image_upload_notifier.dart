import 'dart:io';
import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/image_upload/models/file_type.dart';
import 'package:instagram_clone_course/state/image_upload/typedefs/is_loading.dart';
import 'package:instagram_clone_course/state/post_settings/constants/models/post_setting.dart';
import 'package:instagram_clone_course/state/posts/typedefs/user_id.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;

    late Uint8List thumbnailUint8List;

    switch (fileType) {
      case FileType.image:
      // TODO: Handle this case.
      case FileType.video:
      // TODO: Handle this case.
    }
  }
}
