import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/post_settings/constants/models/post_setting.dart';
import 'package:instagram_clone_course/state/post_settings/constants/notifiers/post_setting_notifier.dart';

final postSettingProvider =
    StateNotifierProvider<PostSettingNotifier, Map<PostSetting, bool>>(
  (ref) => PostSettingNotifier(),
);
