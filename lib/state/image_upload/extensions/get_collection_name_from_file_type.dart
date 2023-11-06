import 'package:instagram_clone_course/state/image_upload/models/file_type.dart';

extension CollectionName on FileType {
  String get collectionName => switch (this) {
        FileType.image => 'images',
        FileType.video => 'videos',
      };
}
