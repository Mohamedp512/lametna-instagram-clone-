import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/state/auth/providers/auth_state_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home Page',
          ),
        ),
        body: Consumer(
          builder: (_, ref, child) {
            return TextButton(
              onPressed: () async {
                await ref.read(authStateProvider.notifier).logout();
              },
              child: const Text('Logout'),
            );
          },
        ));
  }
}
