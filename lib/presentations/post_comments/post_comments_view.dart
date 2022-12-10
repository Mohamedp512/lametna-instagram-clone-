import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/extensions/object/dimiss_keyboard.dart';
import 'package:instantgram/presentations/components/animations/empty_content_animation_view.dart';
import 'package:instantgram/presentations/components/animations/empty_content_animation_view_with_text.dart';
import 'package:instantgram/presentations/components/animations/error_animation_view.dart';
import 'package:instantgram/presentations/components/animations/loading_animation_view.dart';
import 'package:instantgram/presentations/components/animations/lottie_animation_view.dart';
import 'package:instantgram/presentations/components/comment/comment_tile.dart';
import 'package:instantgram/presentations/constants/strings.dart';
import 'package:instantgram/state/auth/providers/user_id_provider.dart';
import 'package:instantgram/state/comments/model/post_comment_request.dart';
import 'package:instantgram/state/comments/providers/post_comment_provider.dart';
import 'package:instantgram/state/comments/providers/send_comment_provider.dart';

import 'package:instantgram/state/posts/typedefs/post_id.dart';

class PostCommentView extends HookConsumerWidget {
  final PostId postId;

  const PostCommentView({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(RequestForPostAndComments(
      postId: postId,
    ));
    final comments = ref.watch(postCommentProviders(request.value));
    useEffect(
      () {
        commentController.addListener(() {
          hasText.value = commentController.text.isNotEmpty;
        });
        return () {};
      },
      [
        commentController,
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.comments,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: hasText.value
                ? () {
                    _submitCommentWithController(
                      commentController,
                      ref,
                    );
                  }
                : null,
          )
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data: (comments) {
                  if (comments.isEmpty) {
                    return const SingleChildScrollView(
                      child: EmptyContentWithTextAnimationView(
                        text: Strings.noCommentsYet,
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () {
                      ref.refresh(
                        postCommentProviders(
                          request.value,
                        ),
                      );
                      return Future.delayed(
                        const Duration(seconds: 1),
                      );
                    },
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments.elementAt(index);
                          print('ccccoment:${comment.comment}');
                          return CommentTile(comment: comment);
                        }),
                  );
                },
                error: (error, stackTrace) {
                  return const ErrorLottieAnimationView();
                },
                loading: () {
                  return const LoadingLottieAnimationView();
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    controller: commentController,
                    onSubmitted: (comment) {
                      _submitCommentWithController(
                        commentController,
                        ref,
                      );
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Strings.writeYourCommentHere,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
      TextEditingController controller, WidgetRef ref) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
          userId: userId,
          postId: postId,
          comment: controller.text,
        );
    if (isSent) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
