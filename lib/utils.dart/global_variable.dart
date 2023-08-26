import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/screens/add_post_screen.dart';
import 'package:instagram_clone/ui/screens/feed_screen.dart';
import 'package:instagram_clone/ui/screens/profile_screen.dart';
import 'package:instagram_clone/ui/screens/search_screen.dart';

const webScreenSize = 600;
const HomePageItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("FavoriteScreen"),
  ProfileScreen(),
];
