import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/controller/post_controller.dart';
import 'package:instagram_clone/error_text.dart';
import 'package:instagram_clone/model/user_model.dart';
import 'package:instagram_clone/ui/widget/column_card.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

class ProfileScreen extends ConsumerWidget {
  final UserModel? otherUser;
  const ProfileScreen({
    super.key,
    this.otherUser,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(user.username),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profilepic),
                      radius: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ColumnCard(
                                    value: user.posts.toString(),
                                    label: "posts"),
                                ColumnCard(
                                    value: user.followers.length.toString(),
                                    label: "Followers"),
                                ColumnCard(
                                    value: user.following.length.toString(),
                                    label: "Following"),
                              ],
                            ),
                            Row(children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border:
                                            Border.all(color: secondaryColor),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text('Edit Profile')),
                                ),
                              )
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user.bio,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          ref.watch(userPostProvider(user.uid)).when(
                data: (data) => GridView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 1.5),
                    itemBuilder: (context, index) {
                      final post = data[index];
                      return Image(
                        image: NetworkImage(post.postUrl),
                      );
                    }),
                error: ((error, stackTrace) => ErrorText(
                      text: error.toString(),
                    )),
                loading: () => loader(),
              )
        ],
      ),
    );
  }
}
