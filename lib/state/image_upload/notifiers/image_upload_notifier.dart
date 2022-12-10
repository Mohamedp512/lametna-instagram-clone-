import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/extensions/object/get_collection_name_from_file_type.dart';
import 'package:instantgram/extensions/object/get_image_data_aspect_ratio.dart';
import 'package:instantgram/presentations/constants/strings.dart';
import 'package:instantgram/state/constants/firebase_collection_name.dart';
import 'package:instantgram/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:instantgram/state/image_upload/models/file_type.dart';
import 'package:instantgram/state/image_upload/type_def.dart';
import 'package:instantgram/state/post_settings/models/post_setting.dart';
import 'package:instantgram/state/posts/models/post_payload.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> upload(
      {required File file,
      required FileType fileType,
      required String message,
      required Map<PostSettings, bool> postSettings,
      required String userId}) async {
    isLoading = true;
    late Uint8List thumbnailUint8List;
    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          return false;
        }
        final thumbnail = img.copyResize(
          fileAsImage,
          width: Strings.imageThumbnailWidth,
        );
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: Strings.videoThumbnailMaxHeight,
          quality: Strings.videoThumbnailQuality,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        } else {
          thumbnailUint8List = thumb;
        }
        break;
    }

    //calculate the aspect ratio
    final thumbnailAspectRatio = await thumbnailUint8List.getAspectRatio();
    final fileName = const Uuid().v4();
    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);
    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);
    //upload the thumbnail
    try {
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

//upload original image
      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;

//upload the post itself
      final postPayLoad = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalFileStorageId,
        postSettings: postSettings,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayLoad);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
