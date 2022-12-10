import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/presentations/components/animations/loading_animation_view.dart';
import 'package:instantgram/presentations/components/animations/small_error_animation_view.dart';
import 'package:instantgram/state/image_upload/models/thumbnail_request.dart';
import 'package:instantgram/state/image_upload/providers/thumbnail_provider.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;
  const FileThumbnailView({
    Key? key,
    required this.thumbnailRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(thumbnailRequest));
    return thumbnail.when(data: (imageWithAspectRatio) {
      return AspectRatio(
        aspectRatio: imageWithAspectRatio.aspectRatio,
        child: imageWithAspectRatio.image,
      );
    }, error: (error, stackTrace) {
      return const SmallErrorLottieAnimationView();
    }, loading: () {
      return const LoadingLottieAnimationView();
    });
  }
}
