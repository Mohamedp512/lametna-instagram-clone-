import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/state/post_settings/models/post_setting.dart';
import 'package:instantgram/state/post_settings/notifiers/post_setting_notifier.dart';

final postSettingProvider =
    StateNotifierProvider<PostSettingNotifier, Map<PostSettings, bool>>(
  (ref) => PostSettingNotifier(),
);
