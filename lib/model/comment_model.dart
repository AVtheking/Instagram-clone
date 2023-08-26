// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CommentModel {
  final String commentId;
  final String comment;
  final String username;
  final String uid;
  final String profileUrl;
  final DateTime createdAt;
  final List likes;
  CommentModel({
    required this.commentId,
    required this.comment,
    required this.username,
    required this.uid,
    required this.profileUrl,
    required this.createdAt,
    required this.likes,
  });

  CommentModel copyWith({
    String? commentId,
    String? comment,
    String? username,
    String? uid,
    String? profileUrl,
    DateTime? createdAt,
    List? likes,
  }) {
    return CommentModel(
      commentId: commentId ?? this.commentId,
      comment: comment ?? this.comment,
      username: username ?? this.username,
      uid: uid ?? this.uid,
      profileUrl: profileUrl ?? this.profileUrl,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentId': commentId,
      'comment': comment,
      'username': username,
      'uid': uid,
      'profileUrl': profileUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likes': likes,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['commentId'] as String,
      comment: map['comment'] as String,
      username: map['username'] as String,
      uid: map['uid'] as String,
      profileUrl: map['profileUrl'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      likes: List.from((map['likes'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommentModel(commentId: $commentId, comment: $comment, username: $username, uid: $uid, profileUrl: $profileUrl, createdAt: $createdAt, likes: $likes)';
  }

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;

    return other.commentId == commentId &&
        other.comment == comment &&
        other.username == username &&
        other.uid == uid &&
        other.profileUrl == profileUrl &&
        other.createdAt == createdAt &&
        listEquals(other.likes, likes);
  }

  @override
  int get hashCode {
    return commentId.hashCode ^
        comment.hashCode ^
        username.hashCode ^
        uid.hashCode ^
        profileUrl.hashCode ^
        createdAt.hashCode ^
        likes.hashCode;
  }
}
