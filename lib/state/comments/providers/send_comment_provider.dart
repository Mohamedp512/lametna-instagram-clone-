import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/state/comments/notifiers/send_coment_notifier.dart';

final sendCommentProvider = StateNotifierProvider<SendCommentNotifier, bool>(
  (ref) => SendCommentNotifier(),
);
