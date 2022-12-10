import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/presentations/components/dialogs/alert_dialog_model.dart';
import 'package:instantgram/presentations/components/dialogs/log_out_dialog.dart';
import 'package:instantgram/presentations/constants/strings.dart';
import 'package:instantgram/presentations/post/create_new_post_view.dart';
import 'package:instantgram/presentations/tabs/user_posts/user_posts_view.dart';
import 'package:instantgram/state/auth/providers/auth_state_provider.dart';
import 'package:instantgram/state/image_upload/helper/image_picker_helper.dart';
import 'package:instantgram/state/image_upload/models/file_type.dart';
import 'package:instantgram/state/post_settings/providers/post_setting_provider.dart';

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
              // ignore: prefer_const_constructors
              icon: FaIcon(
                FontAwesomeIcons.film,
              ),
              onPressed: () async {
//pick a video first
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();
                if (videoFile == null) {
                  return;
                }
                ref.refresh(postSettingProvider);
                if (!mounted) {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                        fileToPost: videoFile, fileType: FileType.video),
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () async {
                final imageFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (imageFile == null) {
                  return;
                }
                //reset the postSetting provider

                ref.refresh(postSettingProvider);
                if (!mounted) {
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                        fileToPost: imageFile, fileType: FileType.image),
                  ),
                );
              },
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.add_photo_alternate_outlined,
              ),
            ),
            IconButton(
              onPressed: () async {
                final shouldLogOut =
                    await const LogoutDialog().present(context).then(
                          (value) => value ?? false,
                        );
                if (shouldLogOut) {
                  ref.read(authStateProvider.notifier).logout();
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
            Icon(Icons.search),
            Tab(
              icon: Icon(Icons.home),
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            UserPostView(),
            UserPostView(),
            UserPostView(),
          ],
        ),
      ),
    );
  }
}
