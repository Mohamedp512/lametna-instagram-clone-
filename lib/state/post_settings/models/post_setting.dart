import 'package:instantgram/state/post_settings/constant/post_constants.dart';

enum PostSettings {
  allowLikes(
    title: PostConstants.allowLikesTitle,
    description: PostConstants.allowLikesDescription,
    storageKey: PostConstants.allowLikesStorageKey,
  ),
  allowComments(
    title: PostConstants.allowCommentsTitle,
    description: PostConstants.allowCommentsDescription,
    storageKey: PostConstants.allowCommentsStorageKey,
  );

  final String title;
  final String description;
  final String storageKey;
  const PostSettings({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
