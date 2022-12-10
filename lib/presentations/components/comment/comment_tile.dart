import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/presentations/components/animations/small_error_animation_view.dart';
import 'package:instantgram/presentations/components/dialogs/alert_dialog_model.dart';
import 'package:instantgram/presentations/components/dialogs/delete_dialog.dart';
import 'package:instantgram/presentations/constants/strings.dart';
import 'package:instantgram/state/auth/providers/user_id_provider.dart';
import 'package:instantgram/state/comments/model/comment.dart';
import 'package:instantgram/state/comments/providers/delete_comment_provider.dart';
import 'package:instantgram/state/user_info/providers/user_info_model_provider.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({
    required this.comment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(
        comment.fromUserId,
      ),
    );
    print('Iusssssssssssssss${comment.fromUserId}');
    print('usssssssssssssss${userInfo.value}');
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
                          .deleteComment(
                            commentId: comment.id,
                          );
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                )
              : null,
          title: Text(userInfo.displayName),
           subtitle: Text(comment.comment),
        );
      },
      error: (error, stackTrace) {
        return const SmallErrorLottieAnimationView();
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      const DeleteDialog(titleOfObjectToDelete: Strings.comments)
          .present(context)
          .then((value) => value ?? false);
}
