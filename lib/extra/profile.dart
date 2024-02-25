import 'package:demos/extra/follow_button.dart';
import 'package:demos/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            body: Container(
              color: const Color(0xff121421),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                user.photoURL ?? Globals.dummyProfileImageUrl,
                              ),
                              radius: 40,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildStatColumn(postLen, 'keys'),
                                      buildStatColumn(0, "followers"),
                                      buildStatColumn(0, "following"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FollowButton(
                                        text: 'Sign Out',
                                        backgroundColor: Colors.purple,
                                        textColor: Colors.white,
                                        borderColor: Colors.transparent,
                                        function: () async {},
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (user.isAnonymous) ...[
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: Text(
                              'Mr. Anonymous',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                            top: 1,
                          ),
                          child: Text(
                            'UID: ${user.uid}',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: Center(
                      child: Text(
                        'No Keys Yet',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  )
                  // FutureBuilder(
                  //   future: FirebaseFirestore.instance
                  //       .collection('ig_clone_posts')
                  //       .where('uid', isEqualTo: widget.uid)
                  //       .get(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     }

                  //     return GridView.builder(
                  //       shrinkWrap: true,
                  //       itemCount: (snapshot.data! as dynamic).docs.length,
                  //       gridDelegate:
                  //           const SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 3,
                  //         crossAxisSpacing: 5,
                  //         mainAxisSpacing: 1.5,
                  //         childAspectRatio: 1,
                  //       ),
                  //       itemBuilder: (context, index) {
                  //         DocumentSnapshot snap =
                  //             (snapshot.data! as dynamic).docs[index];

                  //         return SizedBox(
                  //           child: Image(
                  //             image: NetworkImage(snap['postUrl']),
                  //             fit: BoxFit.cover,
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  // )
                ],
              ),
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
