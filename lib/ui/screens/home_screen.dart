import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils.dart/global_variable.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageInd = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageItems[pageInd],
      bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          currentIndex: pageInd,
          activeColor: primaryColor,
          onTap: (index) {
            setState(() {
              pageInd = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
                backgroundColor: mobileBackgroundColor),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ]),
    );
  }
}
