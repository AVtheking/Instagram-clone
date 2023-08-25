import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/Provider/firebase_provider.dart';
import 'package:instagram_clone/failure.dart';
import 'package:instagram_clone/model/post_model.dart';
import 'package:instagram_clone/typedef.dart';

final postRepositoryProvider =
    Provider((ref) => PostRepository(firestore: ref.read(firestoreProvider)));

class PostRepository {
  final FirebaseFirestore _firestore;
  PostRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureVoid savePost(Post post) async {
    try {
      return right(await _firestore
          .collection('posts')
          .doc(post.postId)
          .set(post.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Post>> fetchPost() {
    return _firestore.collection('posts').snapshots().map((event) {
      List<Post> posts = [];
      for (var post in event.docs) {
        posts.add(Post.fromMap(post.data()));
      }
      return posts;
    });
  }
}
