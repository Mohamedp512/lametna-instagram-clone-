import 'package:instantgram/presentations/components/animations/lottie_animation_view.dart';
import 'package:instantgram/presentations/components/animations/models/lottie_animation.dart';

class DataNotFoundLottieAnimationView extends LottieAnimationView {
  const DataNotFoundLottieAnimationView({super.key})
      : super(
          animation: LottieAnimation.dataNotFound,
        );
}
