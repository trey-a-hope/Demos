import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/models/user.dart';

class UserListTile extends StatefulWidget {
  final User user;

  const UserListTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50.0, // Adjust the size as needed
        height: 50.0,

        child: CircleAvatar(
          backgroundColor: Colors.white, // Background color inside the border
          backgroundImage: NetworkImage(widget.user.photoUrl),
        ),
      ),
      title: Text(widget.user.username),
      trailing: Container(
        width: 100.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: widget.user.online
              ? Colors.green
              : Colors.grey, // Change the color as needed
          borderRadius:
              BorderRadius.circular(10.0), // Adjust the radius as needed
        ),
        child: Center(
          child: Text(
            widget.user.online ? 'Online' : 'Offline',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
