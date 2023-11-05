import 'package:instagram_clone_course/views/compoents/animations/models/lottie_animation.dart';
import 'package:instagram_clone_course/views/compoents/animations/models/lottie_animation_view.dart';

class LoadingAnimationView extends LottieAnimationView {
  const LoadingAnimationView({super.key})
      : super(
          animation: LottieAnimation.loading,
        );
}
