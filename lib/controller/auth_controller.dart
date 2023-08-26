import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Provider/firebase_provider.dart';
import 'package:instagram_clone/Provider/storage_provider.dart';
import 'package:instagram_clone/model/user_model.dart';
import 'package:instagram_clone/repository/auth_repository.dart';
import 'package:instagram_clone/ui/screens/home_screen.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);
final userDataProvider = StreamProvider.family((ref, String uid) =>
    ref.read(authControllerProvider.notifier).getUserData(uid));

final stateChangeProvider = StreamProvider(
    (ref) => ref.read(authControllerProvider.notifier).authStateChange);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.read(authRepositoryProvider),
    ref: ref,
    auth: ref.read(authProvider),
    storageRepository: ref.read(storageProvider),
  ),
);
final userOnSearchProvider = StreamProvider.family((ref, String query) =>
    ref.read(authControllerProvider.notifier).getUseOnSearch(query));

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  final FirebaseAuth _auth;
  final StorageRepository _storageRepository;
  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
    required FirebaseAuth auth,
    required StorageRepository storageRepository,
  })  : _auth = auth,
        _authRepository = authRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);
  Stream<User?> get authStateChange => _auth.authStateChanges();
  Stream<UserModel?> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required BuildContext context,
    File? file,
  }) async {
    try {
      state = true;
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String profilePic = '';

        final res = await _storageRepository.storeFiles(
          path: 'profilepic',
          id: cred.user!.uid,
          file: file,
        );
        res.fold(
          (l) => showSnackBar(context, l.message),
          (r) => profilePic = r,
        );

        UserModel user = UserModel(
          posts: 0,
          uid: cred.user!.uid,
          username: username,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          profilepic: profilePic,
        );
        final result = await _authRepository.signInUser(user);
        state = false;
        result.fold((l) => showSnackBar(context, l.message), (r) {
          showSnackBar(context, "Signed in Successfully");
          _ref.watch(userProvider.notifier).update((state) => r);
          Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => const HomeScreen())));
        });
      } else {
        state = false;
        showSnackBar(context, "Error in Sigining\nPlease Enter all details");
      }
    } catch (e) {
      state = false;
      showSnackBar(context, "Error Occured ${e.toString()}");
    }
  }

  void loginInUser(String email, String password, BuildContext context) async {
    try {
      state = true;
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        state = false;
        // showSnackBar(context, "LoggedInSuccessfully");
      } else {
        state = false;
        showSnackBar(context, "Error \nPlease Enter all details");
      }
    } catch (e) {
      state = false;
      showSnackBar(context, e.toString());
    }
  }

  Stream<List<UserModel>> getUseOnSearch(String query) {
    return _authRepository.getUseOnSearch(query);
  }
}
