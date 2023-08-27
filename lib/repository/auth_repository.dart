import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/Provider/firebase_provider.dart';
import 'package:instagram_clone/failure.dart';
import 'package:instagram_clone/model/user_model.dart';
import 'package:instagram_clone/typedef.dart';

final authRepositoryProvider =
    Provider((ref) => AuthRepository(firestore: ref.read(firestoreProvider)));

class AuthRepository {
  final FirebaseFirestore _firestore;
  AuthRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureEither<UserModel> signInUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(
            user.toMap(),
          );
      return right(user);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Stream<List<UserModel>> getUseOnSearch(String query) {
    return _firestore
        .collection('users')
        .where(
          'username',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(query.codeUnitAt(query.length - 1) + 1),
        )
        .snapshots()
        .map((event) {
      List<UserModel> users = [];
      for (var user in event.docs) {
        users.add(
          UserModel.fromMap(user.data()),
        );
      }
      return users;
    });
  }

  void addFollowers(UserModel selectedUUser, UserModel currentUser) async {
    if (selectedUUser.followers.contains(currentUser.uid)) {
      await _firestore.collection('users').doc(selectedUUser.uid).update({
        'followers': FieldValue.arrayRemove([currentUser.uid]),
      });
      await _firestore.collection('users').doc(currentUser.uid).update({
        'following': FieldValue.arrayRemove([currentUser.uid]),
      });
    } else {
      await _firestore.collection('users').doc(selectedUUser.uid).update({
        'followers': FieldValue.arrayUnion([currentUser.uid]),
      });
      await _firestore.collection('users').doc(currentUser.uid).update({
        'following': FieldValue.arrayUnion([selectedUUser.uid]),
      });
    }
  }
}
