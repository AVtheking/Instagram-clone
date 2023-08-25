import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Provider/storage_provider.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/model/post_model.dart';
import 'package:instagram_clone/repository/post_repository.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';
import 'package:uuid/uuid.dart';

final postControllerProvider = StateNotifierProvider<PostController, bool>(
  (ref) => PostController(
    postRepository: ref.read(postRepositoryProvider),
    ref: ref,
    storageRepository: ref.read(storageProvider),
  ),
);
final postProvider = StreamProvider(
    (ref) => ref.read(postControllerProvider.notifier).fetchPost());

class PostController extends StateNotifier<bool> {
  final PostRepository _postRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  PostController(
      {required PostRepository postRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _postRepository = postRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void savePost(
      {required String description,
      required File? file,
      required BuildContext context}) async {
    state = true;
    final user = _ref.read(userProvider)!;
    final postId = const Uuid().v1();
    String postUrl = '';
    if (file != null) {
      final res = await _storageRepository.storeFiles(
          path: 'postPhotos', id: postId, file: file);
      res.fold((l) => showSnackBar(context, l.message), (r) => postUrl = r);
    }
    if (postUrl != '') {
      Post post = Post(
          postId: postId,
          description: description,
          uid: user.uid,
          commentCount: 0,
          username: user.username,
          profileImg: user.profilepic,
          postUrl: postUrl,
          createdAt: DateTime.now(),
          likes: []);
      final result = await _postRepository.savePost(post);
      state = false;
      result.fold((l) => showSnackBar(context, l.message),
          (r) => showSnackBar(context, "Posted Successfully"));
    } else {
      showSnackBar(context, "Some Error Occured\n Please try again ");
    }
  }

  Stream<List<Post>> fetchPost() {
    return _postRepository.fetchPost();
  }
}
