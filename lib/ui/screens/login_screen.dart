import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/ui/screens/sign_in_screen.dart';
import 'package:instagram_clone/ui/widget/text_input.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void navigateToSignInScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  void logInUser(BuildContext context) {
    ref.read(authControllerProvider.notifier).loginInUser(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return isLoading
        ? loader()
        : Scaffold(
            body: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                    SvgPicture.asset(
                      'assets/ic_instagram.svg',
                      color: primaryColor,
                      height: 64,
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    TextInputField(
                      textController: _emailController,
                      hint: "Enter your email",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextInputField(
                      textController: _passwordController,
                      hint: "Enter your password",
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () => logInUser(context),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: ShapeDecoration(
                          color: blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text("Log in "),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Don't have an account?"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            onTap: navigateToSignInScreen,
                            child: const Text(
                              "Sign in",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
