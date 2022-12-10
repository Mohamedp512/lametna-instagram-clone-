import 'package:instantgram/presentations/components/animations/lottie_animation_view.dart';
import 'package:instantgram/presentations/components/animations/models/lottie_animation.dart';

class SmallErrorLottieAnimationView extends LottieAnimationView {
  const SmallErrorLottieAnimationView({super.key})
      : super(
          animation: LottieAnimation.smallError,
        );
}
