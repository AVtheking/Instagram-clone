// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Post {
  final String postId;
  final String description;
  final String uid;
  final String username;
  final String profileImg;
  final String postUrl;
  final DateTime createdAt;
  final List likes;
  Post({
    required this.postId,
    required this.description,
    required this.uid,
    required this.username,
    required this.profileImg,
    required this.postUrl,
    required this.createdAt,
    required this.likes,
  });

  Post copyWith({
    String? postId,
    String? description,
    String? uid,
    String? username,
    String? profileImg,
    String? postUrl,
    DateTime? createdAt,
    List? likes,
  }) {
    return Post(
      postId: postId ?? this.postId,
      description: description ?? this.description,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      profileImg: profileImg ?? this.profileImg,
      postUrl: postUrl ?? this.postUrl,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'description': description,
      'uid': uid,
      'username': username,
      'profileImg': profileImg,
      'postUrl': postUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likes': likes,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] as String,
      description: map['description'] as String,
      uid: map['uid'] as String,
      username: map['username'] as String,
      profileImg: map['profileImg'] as String,
      postUrl: map['postUrl'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      likes: List.from((map['likes'] as List)),
    );
  }

  
  @override
  String toString() {
    return 'Post(postId: $postId, description: $description, uid: $uid, username: $username, profileImg: $profileImg, postUrl: $postUrl, createdAt: $createdAt, likes: $likes)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.postId == postId &&
        other.description == description &&
        other.uid == uid &&
        other.username == username &&
        other.profileImg == profileImg &&
        other.postUrl == postUrl &&
        other.createdAt == createdAt &&
        listEquals(other.likes, likes);
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        description.hashCode ^
        uid.hashCode ^
        username.hashCode ^
        profileImg.hashCode ^
        postUrl.hashCode ^
        createdAt.hashCode ^
        likes.hashCode;
  }
}
