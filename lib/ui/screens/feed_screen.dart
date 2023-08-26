import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/controller/post_controller.dart';
import 'package:instagram_clone/error_text.dart';
import 'package:instagram_clone/ui/widget/post_card.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 32,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.messenger_outline,
                color: primaryColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: ref.watch(postProvider).when(
              data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, index) {
                  final post = data[index];
                  return PostCard(
                    post: post,
                    user: user,
                  );
                },
              ),
              error: ((error, stackTrace) => ErrorText(
                    text: error.toString(),
                  )),
              loading: () => loader(),
            ));
  }
}
