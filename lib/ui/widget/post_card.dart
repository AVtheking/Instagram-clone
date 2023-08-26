import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/controller/post_controller.dart';
import 'package:instagram_clone/model/post_model.dart';
import 'package:instagram_clone/model/user_model.dart';
import 'package:instagram_clone/ui/screens/comment_screen.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';
import 'package:intl/intl.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  final UserModel user;
  const PostCard({
    super.key,
    required this.user,
    required this.post,
  });
  showDialogOption(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Delete"),
              ),
            )
          ],
        );
      },
    );
  }

  void navigateToCommentScreen(BuildContext context, Post post) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CommentScreen(post: post),
      ),
    );
  }

  void updateLikes(Post post, WidgetRef ref) {
    ref.read(postControllerProvider.notifier).updateLikes(post);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(post.profileImg),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    post.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => showDialogOption(context),
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: GestureDetector(
              onDoubleTap: () => updateLikes(post, ref),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Image.network(
                  post.postUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  updateLikes(post, ref);
                },
                icon: post.likes.contains(user.uid)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_border),
              ),
              // const SizedBox(
              //   width: 5,
              // ),
              IconButton(
                onPressed: () {
                  navigateToCommentScreen(context, post);
                },
                icon: const Icon(Icons.comment_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.bookmark_border_outlined),
                  onPressed: () {},
                ),
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${post.likes.length} likes',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: post.username),
                        const TextSpan(text: ' '),
                        TextSpan(text: post.description),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "View all ${post.commentCount} comments",
                      style:
                          const TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ),
                Text(
                  DateFormat('d MMM y').format(post.createdAt),
                  style: const TextStyle(fontSize: 16, color: secondaryColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
