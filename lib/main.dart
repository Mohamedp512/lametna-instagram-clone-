import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/extensions/object/log.dart';
import 'package:instantgram/presentations/loading/loading_screen.dart';
import 'package:instantgram/presentations/login_view.dart';
import 'package:instantgram/presentations/main_view.dart';
import 'package:instantgram/state/auth/providers/is_logged_in_provider.dart';
import 'package:instantgram/state/providers/is_loading_provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        indicatorColor: Colors.blueGrey,
        primarySwatch: Colors.blueGrey,
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: Consumer(builder: (context, ref, child) {
        ref.listen<bool>(isLoadingProvider, (_, isLoading) {
          if (isLoading) {
            LoadingScreen.instance().show(context: context);
          } else {
            LoadingScreen.instance().hide();
          }
        });
        final isLoggedIn = ref.watch(isLoggedProvider);
        isLoggedIn.log();
        if (isLoggedIn) {
          return const MainView();
        } else {
          return const LoginView();
        }
      }),
    );
  }
}
