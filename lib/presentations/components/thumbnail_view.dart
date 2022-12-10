import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/presentations/components/animations/loading_animation_view.dart';
import 'package:instantgram/presentations/components/animations/small_error_animation_view.dart';
import 'package:instantgram/state/image_upload/models/thumbnail_request.dart';
import 'package:instantgram/state/image_upload/providers/thumbnail_provider.dart';

class ThumbnailView extends ConsumerWidget {
  final ThumbnailRequest request;
  const ThumbnailView({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(request));
    return thumbnail.when(
      data: (imageWithAspectRatio) {
        return AspectRatio(
          aspectRatio: imageWithAspectRatio.aspectRatio,
          child: imageWithAspectRatio.image,
        );
      },
      error: (error, stackTrace) => const SmallErrorLottieAnimationView(),
      loading: () => const LoadingLottieAnimationView(),
    );
  }
}
