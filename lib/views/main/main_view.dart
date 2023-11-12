import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_course/state/image_upload/helps/image_picker_helper.dart';
import 'package:instagram_clone_course/state/image_upload/models/file_type.dart';
import 'package:instagram_clone_course/state/post_settings/providers/post_setting_provider.dart';
import 'package:instagram_clone_course/views/components/dialogs/alert_diaglog_model.dart';
import 'package:instagram_clone_course/views/components/dialogs/logout_dialog.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';
import 'package:instagram_clone_course/views/create_new_post/create_new_post_view.dart';
import 'package:instagram_clone_course/views/tabs/home/home_view.dart';
import 'package:instagram_clone_course/views/tabs/search/search_view.dart';
import 'package:instagram_clone_course/views/tabs/user_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.film),
              onPressed: () async {
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();
                if (videoFile == null) {
                  return;
                }
                final _ = ref.refresh(postSettingProvider);

                if (!mounted) {
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileToPost: videoFile,
                      fileType: FileType.video,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_photo_alternate_outlined),
              onPressed: () async {
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (imageFile == null) {
                  return;
                }
                final _ = ref.refresh(postSettingProvider);

                if (!mounted) {
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                      fileToPost: imageFile,
                      fileType: FileType.image,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () async {
                final shouldLogOut = await const LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);
                if (shouldLogOut) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.person),
            ),
            Tab(
              icon: Icon(Icons.search),
            ),
            Tab(
              icon: Icon(Icons.home),
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            UserPostsView(),
            SearchView(),
            HomeView(),
          ],
        ),
      ),
    );
  }
}
