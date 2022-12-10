import 'dart:collection' show MapView;
import 'package:flutter/foundation.dart' show immutable;
import 'package:instantgram/state/constants/firebase_field_name.dart';
import 'package:instantgram/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, dynamic> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName ?? '',
          FirebaseFieldName.email: email ?? '',
        });
}
