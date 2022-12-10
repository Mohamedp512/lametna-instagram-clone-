import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/app_colors.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final IconData icon;
  const SocialButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.loginButtonColor,
          foregroundColor: AppColors.loginButtonTextColor,
        ),
        onPressed: onPressed,
        child: SizedBox(
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                icon,
                color: color,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(text)
            ],
          ),
        ));
  }
}
