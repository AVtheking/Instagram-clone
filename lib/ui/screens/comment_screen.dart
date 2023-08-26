import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/controller/post_controller.dart';
import 'package:instagram_clone/error_text.dart';
import 'package:instagram_clone/model/post_model.dart';
import 'package:instagram_clone/ui/widget/comment_card.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final Post post;
  const CommentScreen({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  final TextEditingController commentController = TextEditingController();
  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void addComment(WidgetRef ref, BuildContext context) {
    ref
        .watch(postControllerProvider.notifier)
        .addComments(widget.post, commentController.text.trim(), context);
    commentController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
      ),
      body: ref.watch(commentProvider(widget.post)).when(
            data: (data) => Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (ctx, index) {
                      final comment = data[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CommentCard(comment: comment),
                      );
                    },
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: commentController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "Comment"),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            addComment(ref, context);
                          })
                    ],
                  ),
                )
              ],
            ),
            error: (error, stackTrace) => ErrorText(text: error.toString()),
            loading: () => loader(),
          ),
    );
  }
}
