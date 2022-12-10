import 'package:flutter/material.dart';
import 'package:instantgram/presentations/post_comments/post_comments_view.dart';
import 'package:instantgram/state/post_settings/models/post.dart';

class PostThumbnailView extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;
  const PostThumbnailView({
    super.key,
    required this.post,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostCommentView(
              postId: post.postId,
            ),
          ),
        );
      },
      child: Image.network(
        post.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
