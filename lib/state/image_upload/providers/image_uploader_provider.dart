import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/state/image_upload/notifiers/image_upload_notifier.dart';
import 'package:instantgram/state/image_upload/type_def.dart';

final imageUploaderProvider =
    StateNotifierProvider<ImageUploadNotifier, IsLoading>(
        (ref) => ImageUploadNotifier());
