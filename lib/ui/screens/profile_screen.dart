import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/controller/post_controller.dart';
import 'package:instagram_clone/error_text.dart';
import 'package:instagram_clone/model/user_model.dart';
import 'package:instagram_clone/ui/widget/column_card.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String? uid;
  const ProfileScreen({
    super.key,
    this.uid,
  });
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends ConsumerState<ProfileScreen> {
  void signOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signOut();
  }

  void addFollowers(WidgetRef ref, UserModel user) {
    ref.watch(authControllerProvider.notifier).addFollowers(user);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: Text(user.username),
        ),
        body: widget.uid == null
            ? ListView(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ColumnCard(
                                            value: user.posts.toString(),
                                            label: "posts"),
                                        ColumnCard(
                                            value: user.followers.length
                                                .toString(),
                                            label: "Followers"),
                                        ColumnCard(
                                            value: user.following.length
                                                .toString(),
                                            label: "Following"),
                                      ],
                                    ),
                                    Row(children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () => signOut(ref),
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: secondaryColor),
                                                ),
                                                alignment: Alignment.center,
                                                child: const Text('Sign out')),
                                          ),
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
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
              )
            : ref.watch(userDataProvider(widget.uid!)).when(
                data: (otherUser) => ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(otherUser!.profilepic),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ColumnCard(
                                                  value: otherUser.posts
                                                      .toString(),
                                                  label: "posts"),
                                              ColumnCard(
                                                  value: otherUser
                                                      .followers.length
                                                      .toString(),
                                                  label: "Followers"),
                                              ColumnCard(
                                                  value: otherUser
                                                      .following.length
                                                      .toString(),
                                                  label: "Following"),
                                            ],
                                          ),
                                          Row(children: [
                                            Expanded(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        otherUser.followers
                                                                .contains(
                                                                    user.uid)
                                                            ? InkWell(
                                                                onTap: () {
                                                                  addFollowers(
                                                                      ref,
                                                                      otherUser);
                                                                },
                                                                child:
                                                                    Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(6),
                                                                          border:
                                                                              Border.all(color: secondaryColor),
                                                                        ),
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        child: const Text(
                                                                            'Unfollow')),
                                                              )
                                                            : InkWell(
                                                                onTap: () {
                                                                  addFollowers(
                                                                      ref,
                                                                      otherUser);
                                                                },
                                                                child:
                                                                    Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.blue,
                                                                          borderRadius:
                                                                              BorderRadius.circular(6),
                                                                          border:
                                                                              Border.all(color: secondaryColor),
                                                                        ),
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        child: const Text(
                                                                            'Follow')),
                                                              )))
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
                                      otherUser.username,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      otherUser.bio,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        ref.watch(userPostProvider(otherUser.uid)).when(
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
                error: (error, stackTrace) => ErrorText(text: error.toString()),
                loading: loader));
  }
}
