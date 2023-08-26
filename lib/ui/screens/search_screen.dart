import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/controller/post_controller.dart';
import 'package:instagram_clone/error_text.dart';
import 'package:instagram_clone/ui/screens/search_user.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SearchUser(),
                ));
              },
              child: SizedBox(
                height: 45,
                width: double.infinity,
                child: Container(
                  decoration: const BoxDecoration(
                    color: mobileBackgroundColor,
                  ),
                  child: const Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.search,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Search")
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: ref.watch(postProvider).when(
              data: (data) {
                return MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: data.length,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  itemBuilder: (context, index) => Image(
                    image: NetworkImage(data[index].postUrl),
                  ),
                );
              },
              error: ((error, stackTrace) => ErrorText(
                    text: error.toString(),
                  )),
              loading: () => loader(),
            ));
  }
}
