import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/models/auth_result.dart';
import 'package:instagram_clone_course/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_course/state/providers/is_loading_pvovider.dart';
import 'package:instagram_clone_course/views/compoents/loading/loading_screen.dart';
import 'package:instagram_clone_course/views/login/login_view.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      home: Consumer(
        builder: (context, ref, child) {
          // Take care of displaying the loading screen.
          ref.listen<bool>(isLoadingProvider, (_, isLoading) {
            if (isLoading) {
              LoadingScreen.instance().show(context: context);
            } else {
              LoadingScreen.instance().hide();
            }
          });
          final isLogged =
              ref.watch(authStateProvider).result == AuthResult.success;

          if (isLogged) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// For when you are already loggin.
class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return TextButton(
            onPressed: () async {
              ref.read(authStateProvider.notifier).logOut();
            },
            child: const Text('Logout'),
          );
        },
      ),
    );
  }
}
