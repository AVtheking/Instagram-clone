import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/model/comment_model.dart';
import 'package:intl/intl.dart';

class CommentCard extends ConsumerWidget {
  final CommentModel comment;
  const CommentCard({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(comment.profileUrl),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: comment.username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                const TextSpan(text: ' '),
                TextSpan(
                  text: comment.comment,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              DateFormat('d MMM y').format(comment.createdAt),
              style: const TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.favorite,
          color: comment.likes.contains(user.uid) ? Colors.red : Colors.white,
        ),
      ),
    );
  }
}
