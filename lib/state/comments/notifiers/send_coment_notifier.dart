import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/state/comments/model/comment_payload.dart';
import 'package:instantgram/state/constants/firebase_collection_name.dart';
import 'package:instantgram/state/image_upload/type_def.dart';
import 'package:instantgram/state/posts/typedefs/post_id.dart';

import '../../posts/typedefs/user_id.dart';

class SendCommentNotifier extends StateNotifier<IsLoading> {
  SendCommentNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> sendComment({
    required UserId userId,
    required PostId postId,
    required String comment,
  }) async {
    isLoading = true;
    final payLoad = CommentPayload(
      fromUserId: userId,
      onPost: postId,
      comment: comment,
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .add(payLoad);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
