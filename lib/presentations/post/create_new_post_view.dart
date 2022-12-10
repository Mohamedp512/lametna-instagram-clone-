import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/state/auth/providers/user_id_provider.dart';

import 'package:instantgram/state/image_upload/models/file_type.dart';
import 'package:instantgram/state/image_upload/models/thumbnail_request.dart';
import 'package:instantgram/state/image_upload/providers/image_uploader_provider.dart';
import 'package:instantgram/state/post_settings/models/post_setting.dart';
import 'package:instantgram/state/post_settings/providers/post_setting_provider.dart';

import '../components/file_thumbnail_view.dart';
import '../constants/strings.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;

  const CreateNewPostView({
    super.key,
    required this.fileToPost,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest =
        ThumbnailRequest(file: widget.fileToPost, fileType: widget.fileType);
    final postSettings = ref.watch(postSettingProvider);
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect(() {
      void listener() {
        isPostButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);
      return () {
        postController.removeListener(listener);
      };
    }, [postController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.createNewPost),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.send,
            ),
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    

                    final message = postController.text;
                    final isUploaded = await ref
                        .read(imageUploaderProvider.notifier)
                        .upload(
                            file: widget.fileToPost,
                            fileType: widget.fileType,
                            message: message,
                            postSettings: postSettings,
                            userId: userId);

                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FileThumbnailView(
            thumbnailRequest: thumbnailRequest,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: postController,
              decoration: const InputDecoration(
                labelText: Strings.pleaseWriteYourMessageHere,
              ),
              autofocus: true,
              maxLines: null,
            ),
          ),
          ...PostSettings.values.map(
            (postSetting) => ListTile(
              title: Text(
                postSetting.title,
              ),
              subtitle: Text(
                postSetting.description,
              ),
              trailing: (Switch(
                value: postSettings[postSetting] ?? false,
                onChanged: (isOn) {
                  ref
                      .read(postSettingProvider.notifier)
                      .setSetting(postSetting, isOn);
                },
              )),
            ),
          )
        ],
      )),
    );
  }
}
