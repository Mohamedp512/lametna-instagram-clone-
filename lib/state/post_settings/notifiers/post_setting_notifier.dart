import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/state/post_settings/models/post_setting.dart';

class PostSettingNotifier extends StateNotifier<Map<PostSettings, bool>> {
  PostSettingNotifier()
      : super(
          UnmodifiableMapView(
            {
              for (final setting in PostSettings.values) setting: true,
            },
          ),
        );
  void setSetting(PostSettings setting, bool value) {
    state = Map.unmodifiable(Map.from(state)..[setting] = value);
  }
}
