import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone_course/views/constants/app_colors.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';

class GithubButton extends StatelessWidget {
  const GithubButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.github,
            color: AppColors.githubColor,
          ),
          const SizedBox(width: 10),
          const Text(Strings.github),
        ],
      ),
    );
  }
}
