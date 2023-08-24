import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/Provider/firebase_provider.dart';
import 'package:instagram_clone/failure.dart';
import 'package:instagram_clone/typedef.dart';

final storageProvider = Provider((ref) =>
    StorageRepository(firebaseStorage: ref.read(firebaseStorageProvider)));

class StorageRepository {
  final FirebaseStorage _firebaseStorage;
  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;
  FutureEither<String> storeFiles({
    required String path,
    required String id,
    required File? file,
  }) async {
    try {
      Reference ref = _firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask = ref.putFile(file!);
      TaskSnapshot snap = await uploadTask;
      return right(await snap.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
