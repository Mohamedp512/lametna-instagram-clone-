import 'package:instantgram/presentations/components/animations/lottie_animation_view.dart';
import 'package:instantgram/presentations/components/animations/models/lottie_animation.dart';

class LoadingLottieAnimationView extends LottieAnimationView {
  const LoadingLottieAnimationView({super.key})
      : super(
          animation: LottieAnimation.loading,
        );
}
