// import 'package:demos/globals.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   final User user;

//   const ProfilePage({
//     super.key,
//     required this.user,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile '),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             CircleAvatar(
//                 radius: 60.0,
//                 backgroundImage: Image.network(
//                   user.photoURL ?? Globals.dummyProfileImageUrl,
//                 ).image),
//             const SizedBox(height: 20.0),
//             const SizedBox(height: 20.0),
//             const Text(
//               'About Me:',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Text(
//                 // If displayName is null, show 'Mr. Anonymous'.
//                 'My name is ${user.displayName ?? 'Mr. Anonymous'}',
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Email?',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Password?',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
