import 'package:instagram_clone_course/views/compoents/animations/models/lottie_animation.dart';
import 'package:instagram_clone_course/views/compoents/animations/models/lottie_animation_view.dart';

class ErrorAnimationView extends LottieAnimationView {
  const ErrorAnimationView({super.key})
      : super(
          animation: LottieAnimation.error,
        );
}
