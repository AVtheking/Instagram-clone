import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/Provider/firebase_provider.dart';
import 'package:instagram_clone/failure.dart';
import 'package:instagram_clone/model/comment_model.dart';
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

  void updateLike(Post post, String uid) async {
    if (post.likes.contains(uid)) {
      _firestore.collection('posts').doc(post.postId).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      _firestore.collection('posts').doc(post.postId).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  void updateCommentLikes(Post post, String uid) async {
    if (post.likes.contains(uid)) {
      _firestore.collection('posts').doc(post.postId).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      _firestore.collection('posts').doc(post.postId).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  FutureVoid addComments(CommentModel commet, Post post) async {
    try {
      await _firestore
          .collection('posts')
          .doc(post.postId)
          .collection('comments')
          .doc(commet.commentId)
          .set(commet.toMap());
      return right(
        _firestore.collection('posts').doc(post.postId).update(
          {'commentCount': FieldValue.increment(1)},
        ),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<CommentModel>> fetchComment(Post post) {
    return _firestore
        .collection('posts')
        .doc(post.postId)
        .collection('comments')
        .snapshots()
        .map((event) {
      List<CommentModel> comments = [];
      for (var comment in event.docs) {
        comments.add(
          CommentModel.fromMap(
            comment.data(),
          ),
        );
      }
      return comments;
    });
  }
}
