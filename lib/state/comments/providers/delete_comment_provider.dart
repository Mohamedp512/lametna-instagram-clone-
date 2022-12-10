import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/state/comments/notifiers/delete_comment_notifier.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteDocumentStateNotifier, bool>(
  (_) => DeleteDocumentStateNotifier(),
);
