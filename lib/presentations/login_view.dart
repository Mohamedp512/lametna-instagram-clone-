import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/presentations/constants/app_colors.dart';
import 'package:instantgram/presentations/constants/strings.dart';
import 'package:instantgram/state/auth/providers/auth_state_provider.dart';

import 'login/components/social_button.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            Strings.appName,
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              Strings.welcomeToAppName,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 60,
            ),
            SocialButton(
              text: Strings.google,
              onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
              color: AppColors.googleColor,
              icon: FontAwesomeIcons.google,
            ),
            const SizedBox(
              height: 20,
            ),
            SocialButton(
              text: Strings.facebook,
              onPressed: ref.read(authStateProvider.notifier).loginWithFacebook,
              color: AppColors.facebookColor,
              icon: FontAwesomeIcons.facebook,
            )
          ],
        ),
      ),
    );
  }
}
