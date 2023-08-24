import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/error_text.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/model/user_model.dart';
import 'package:instagram_clone/ui/screens/home_screen.dart';
import 'package:instagram_clone/ui/screens/login_screen.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  void getData(User data) async {
    userModel = await ref
        .read(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: ref.watch(stateChangeProvider).when(
            data: (data) {
              if (data != null) {
                getData(data);
                if (userModel != null) return const HomeScreen();
              }
              return const LoginScreen();
            },
            error: ((error, stackTrace) => ErrorText(
                  text: error.toString(),
                )),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
