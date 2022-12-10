import 'package:flutter/material.dart';
import 'package:instantgram/presentations/components/animations/empty_content_animation_view.dart';

class EmptyContentWithTextAnimationView extends StatelessWidget {
  final String text;
  const EmptyContentWithTextAnimationView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white54),
            ),
          ),
          const EmptyContentAnimationView(),
        ],
      ),
    );
  }
}
