import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instantgram/state/constants/firebase_collection_name.dart';
import 'package:instantgram/state/constants/firebase_field_name.dart';
import 'package:instantgram/state/posts/typedefs/user_id.dart';
import 'package:instantgram/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();
  Future<bool> saveUserInfoStorage({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
// check if we have this user's info before
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
        });
        return true;
      }
      //create a new user

      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .add(
            payload,
          );
      return true;
    } catch (_) {
      return false;
    }
  }
}
