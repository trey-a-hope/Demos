import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/screens/add_post_screen.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';
import 'package:instagram_clone_flutter/screens/notify_gang_screen.dart';
import 'package:instagram_clone_flutter/screens/profile_screen.dart';
import 'package:instagram_clone_flutter/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const NotifyGangScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];

const String firebaseCloudMessagingAPIKey =
    'AAAAKtv8aAU:APA91bG8xo7bA0EZuHbjnUo6swtLe9MVBFqWGZTmHorydZYaX9nC6YVj6dyADiwnDdxe5vuo-P6_EbHcdixZ4JmZX8SKCAWfjEE70fK-Eou1qMjqDD8MRpioqQTxcHxTN3LVTyk7F7G0';
