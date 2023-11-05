import 'package:instagram_clone_course/views/compoents/animations/models/lottie_animation.dart';
import 'package:instagram_clone_course/views/compoents/animations/models/lottie_animation_view.dart';

class EmptyContentsAnimationView extends LottieAnimationView {
  const EmptyContentsAnimationView({super.key})
      : super(
          animation: LottieAnimation.empty,
        );
}
