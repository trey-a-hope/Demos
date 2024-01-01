import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/models/post.dart';
import 'package:instagram_clone_flutter/models/user.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/global_variable.dart';
import 'package:instagram_clone_flutter/widgets/post_card.dart';
import 'package:instagram_clone_flutter/widgets/story_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    List<Future<QuerySnapshot>> futures = [
      FirebaseFirestore.instance
          .collection('ig_clone_posts')
          .orderBy('datePublished', descending: true)
          .get(),
      FirebaseFirestore.instance.collection('ig_clone_users').get(),
    ];

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: const Text('Finstagram'),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      body: FutureBuilder<List<QuerySnapshot>>(
        future: Future.wait(futures),
        builder: (BuildContext context,
            AsyncSnapshot<List<QuerySnapshot>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Text('Awaiting result...');
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');

              final postDocs = snapshot.data![0];
              final userDocs = snapshot.data![1];

              final posts = postDocs.docs
                  .map((postDoc) => Post.fromSnap(postDoc))
                  .toList();

              final users = userDocs.docs
                  .map((userDoc) => User.fromSnap(userDoc))
                  .toList();

              // Move current user to the top of the list.
              if (users.length > 1) {
                var currentUser = users.removeAt(users.indexWhere(
                    (user) => user.uid == AuthMethods().getCurrentUid()));
                users.insert(0, currentUser);
              }

              return Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: users.length,
                      itemBuilder: (ctx, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: StoryCard(user: users[index]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (_, index) => Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: width > webScreenSize ? width * 0.3 : 0,
                          vertical: width > webScreenSize ? 15 : 0,
                        ),
                        child: PostCard(
                          post: posts[index],
                        ),
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
