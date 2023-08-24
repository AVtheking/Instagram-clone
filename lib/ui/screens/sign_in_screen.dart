import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/ui/screens/home_screen.dart';
import 'package:instagram_clone/ui/screens/login_screen.dart';
import 'package:instagram_clone/ui/widget/text_input.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _bioController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  File? profilePic;

  void selectProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        profilePic = File(res.files.first.path!);
      });
    }
  }

  void signInUser(BuildContext context) {
    ref.read(authControllerProvider.notifier).signUpUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          username: _nameController.text.trim(),
          bio: _bioController.text.trim(),
          file: profilePic,
          context: context,
        );
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => const HomeScreen())));
  }

  void navigateToLoginScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return isLoading
        ? loader()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    SvgPicture.asset(
                      'assets/ic_instagram.svg',
                      color: primaryColor,
                      height: 64,
                    ),
                    const SizedBox(height: 32),
                    Stack(
                      children: [
                        if (profilePic != null)
                          CircleAvatar(
                            backgroundImage: FileImage(profilePic!),
                            radius: 65,
                          )
                        else
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                            ),
                            radius: 65,
                          ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectProfileImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextInputField(
                      textController: _nameController,
                      hint: "Enter username",
                    ),
                    const SizedBox(height: 24),
                    TextInputField(
                      textController: _emailController,
                      hint: "Enter your email",
                    ),
                    const SizedBox(height: 25),
                    TextInputField(
                      textController: _passwordController,
                      hint: "Enter your password",
                      isPass: true,
                    ),
                    const SizedBox(height: 24),
                    TextInputField(
                      textController: _bioController,
                      hint: "Enter your bio",
                    ),
                    const SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        signInUser(context);
                      },
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
                        child: const Text("Sign in"),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Already have an account?"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: navigateToLoginScreen,
                            child: const Text(
                              "Log in",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
