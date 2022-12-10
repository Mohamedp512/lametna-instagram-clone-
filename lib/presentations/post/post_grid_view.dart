import 'package:flutter/cupertino.dart';
import 'package:instantgram/presentations/post/post_thumbnail_view.dart';

import 'package:instantgram/state/post_settings/models/post.dart';

class PostGridView extends StatelessWidget {
  const PostGridView({
    Key? key,
    required this.posts,
  }) : super(key: key);
  final Iterable<Post> posts;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: posts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: ((context, index) => PostThumbnailView(
            post: posts.elementAt(index),
            onTap: () {},
          )),
    );
  }
}
