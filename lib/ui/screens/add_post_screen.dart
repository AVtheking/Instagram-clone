import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/controller/post_controller.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostScreenState();
}

File? file;
pickImage(ImageSource source) async {
  final image = await ImagePicker().pickImage(source: source);
  if (image != null) {
    file = File(image.path);
  }
}

showOptionDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a post"),
          children: [
            SimpleDialogOption(
              onPressed: () {
                pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Take a photo"),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Choose photo from gallery"),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Cancel"),
              ),
            ),
          ],
        );
      });
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  final TextEditingController _description = TextEditingController();
  void addPost(BuildContext context) {
    ref.watch(postControllerProvider.notifier).savePost(
        description: _description.text.trim(), file: file, context: context);
    file = null;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(postControllerProvider);
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("New Post"),
        actions: [
          TextButton(
            onPressed: () {
              addPost(context);
            },
            child: const Text(
              "Post",
              style: TextStyle(color: Colors.blueAccent, fontSize: 17),
            ),
          ),
        ],
      ),
      body: isLoading
          ? loader()
          : file == null
              ? Center(
                  child: IconButton(
                      onPressed: () {
                        showOptionDialog(context);
                      },
                      icon: const Icon(
                        Icons.upload,
                        size: 35,
                      )),
                )
              : ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profilepic),
                    radius: 25,
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.only(left: 15),
                    child: TextField(
                      controller: _description,
                      maxLines: 8,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          // filled: true,
                          hintText: "Write a caption..."),
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Image(
                      image: FileImage(file!),
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
    );
  }
}
