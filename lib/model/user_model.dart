// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String username;
  final String profilepic;
  final String email;
  final int posts;
  final String bio;
  final List followers;
  final List following;
  UserModel({
    required this.uid,
    required this.username,
    required this.profilepic,
    required this.email,
    required this.posts,
    required this.bio,
    required this.followers,
    required this.following,
  });

  UserModel copyWith({
    String? uid,
    String? username,
    String? profilepic,
    String? email,
    int? posts,
    String? bio,
    List? followers,
    List? following,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      profilepic: profilepic ?? this.profilepic,
      email: email ?? this.email,
      posts: posts ?? this.posts,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'profilepic': profilepic,
      'email': email,
      'posts': posts,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      username: map['username'] as String,
      profilepic: map['profilepic'] as String,
      email: map['email'] as String,
      posts: map['posts'] as int,
      bio: map['bio'] as String,
      followers: List.from((map['followers'] as List)),
      following: List.from((map['following'] as List)),
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, username: $username, profilepic: $profilepic, email: $email, posts: $posts, bio: $bio, followers: $followers, following: $following)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.username == username &&
        other.profilepic == profilepic &&
        other.email == email &&
        other.posts == posts &&
        other.bio == bio &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        username.hashCode ^
        profilepic.hashCode ^
        email.hashCode ^
        posts.hashCode ^
        bio.hashCode ^
        followers.hashCode ^
        following.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
