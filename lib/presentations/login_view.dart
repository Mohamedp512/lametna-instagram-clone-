import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/extensions/object/log.dart';
import 'package:instantgram/state/auth/providers/auth_state_provider.dart';

import '../state/auth/backend/authenticator.dart';



class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Login Page',
      )),
      body: Column(
        children: [
          TextButton(
            onPressed:ref.read(authStateProvider.notifier).loginWithGoogle,
            child: const Text('Login with Google'),
          ),
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).loginWithFacebook,
            child: const Text('Login with Facebook'),
          )
        ],
      ),
    );
  }
}
