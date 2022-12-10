import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/presentations/components/animations/empty_content_animation_view_with_text.dart';
import 'package:instantgram/presentations/components/animations/error_animation_view.dart';
import 'package:instantgram/presentations/components/animations/loading_animation_view.dart';
import 'package:instantgram/presentations/post/post_grid_view.dart';
import 'package:instantgram/state/posts/providers/user_post_provider.dart';

import '../../constants/strings.dart';

class UserPostView extends ConsumerWidget {
  const UserPostView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(userPostsProvider);
        return Future.delayed(
          const Duration(
            seconds: 1,
          ),
        );
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentWithTextAnimationView(
                text: Strings.youHaveNoPosts);
          } else {
            return PostGridView(
              posts: posts,
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorLottieAnimationView();
        },
        loading: () {
          return const LoadingLottieAnimationView();
        },
      ),
    );
  }
}
