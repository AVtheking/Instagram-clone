import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/controller/auth_controller.dart';
import 'package:instagram_clone/error_text.dart';
import 'package:instagram_clone/utils.dart/utilts.dart';

class SearchUser extends ConsumerStatefulWidget {
  const SearchUser({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchUserState();
}

class _SearchUserState extends ConsumerState<SearchUser> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: SizedBox(
            height: 45,
            width: double.infinity,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                labelText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )),
      body: ref
          .watch(
            userOnSearchProvider(
              controller.text.trim(),
            ),
          )
          .when(
              data: (data) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        final user = data[index];
                        return InkWell(
                          onTap: () {
                            // navigateToProfileScreen(user.uid);
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.profilepic),
                            ),
                            title: Text(user.username),
                          ),
                        );
                      }),
                    ),
                  ),
              error: (error, stackTrace) => ErrorText(
                    text: error.toString(),
                  ),
              loading: () => loader()),
    );
  }
}
