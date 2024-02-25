import 'package:demos/custom_drawer.dart';
import 'package:demos/extra/category_boxes.dart';
import 'package:demos/extra/discover_card.dart';
import 'package:demos/extra/discover_small_card.dart';
import 'package:demos/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  final User user;

  const DiscoverPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      backgroundColor: const Color(0xff121421),
      drawer: CustomDrawer(
        user: user,
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
                right: 18,
                top: 36,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.isAnonymous
                            ? 'No Display Name'
                            : user.displayName!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                  // InkWell(
                  //   borderRadius: BorderRadius.circular(360),
                  //   onTap: onSearchIconTapped,
                  //   child: Container(
                  //     height: 35,
                  //     width: 35,
                  //     child: Center(
                  //       child: SvgAsset(
                  //         assetName: AssetName.search,
                  //         height: 24,
                  //         width: 24,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(
                    width: 28,
                  ),
                  CategoryBoxes(
                    text: "Flat",
                    onPressed: (value) => {},
                  ),
                  CategoryBoxes(
                    text: "Corrugated",
                    onPressed: (value) => {},
                  ),
                  CategoryBoxes(
                    text: "Warded",
                    onPressed: (value) => {},
                  ),
                  CategoryBoxes(
                    text: "Tubular",
                    onPressed: (value) => {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Favorite Keys",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: onSeeAllTapped,
                    child: const Text(
                      "See All",
                      style: TextStyle(
                          color: Color(0xff4A80F0),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 176,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 28),
                  DiscoverCard(
                    tag: "sleepMeditation",
                    onTap: onSleepMeditationTapped,
                    title: "Warded Key",
                    subtitle:
                        "A warded lock is a type of lock that uses a set of obstructions, or wards, to prevent the lock from opening unless the correct key is inserted.",
                    imgPath: Globals.wardedKey,
                  ),
                  const SizedBox(width: 20),
                  DiscoverCard(
                    onTap: onDepressionHealingTapped,
                    title: "Tubular Key",
                    subtitle:
                        "The design of a tubular lock is similar to the pin tumbler lock, in that there are several stacks of pins. ",
                    gradientStartColor: const Color(0xffFC67A7),
                    gradientEndColor: const Color(0xffF6815B),
                    imgPath: Globals.tubularKey,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Sort keys by",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 19,
                    mainAxisExtent: 125,
                    mainAxisSpacing: 19),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DiscoverSmallCard(
                    onTap: () {},
                    title: "Brand",
                    gradientStartColor: const Color.fromARGB(255, 0, 3, 2),
                    gradientEndColor: const Color(0xff06B782),
                  ),
                  DiscoverSmallCard(
                    onTap: () {},
                    title: "Style",
                    gradientStartColor: const Color(0xffFD541),
                    gradientEndColor: const Color(0xffF6815B),
                    // icon: SvgAsset(
                    //   assetName: AssetName.tape,
                    //   height: 24,
                    //   width: 24,
                    // ),
                  ),
                  DiscoverSmallCard(
                    onTap: () {},
                    title: "Lock Type",
                    gradientStartColor: const Color(0xffFD541),
                    gradientEndColor: const Color(0xffF0B31A),
                  ),
                  DiscoverSmallCard(
                    onTap: () {},
                    title: "Dimensions",
                    gradientStartColor: Colors.lightBlue.shade100,
                    gradientEndColor: Colors.blue.shade900,
                    // icon: SvgAsset(
                    //   assetName: AssetName.tape,
                    //   height: 24,
                    //   width: 24,
                    // ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSeeAllTapped() {}

  void onSleepMeditationTapped() {
    // Get.to(()=> DetailPage(), transition: Transition.rightToLeft);
  }

  void onDepressionHealingTapped() {}

  void onSearchIconTapped() {}
}
