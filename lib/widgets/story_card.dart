import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/models/user.dart';

class StoryCard extends StatefulWidget {
  final User user;

  const StoryCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Center(
            child: Container(
              width: 50.0, // Adjust the size as needed
              height: 50.0,
              decoration: widget.user.online
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    )
                  : null,
              child: CircleAvatar(
                backgroundColor:
                    Colors.white, // Background color inside the border
                backgroundImage: NetworkImage(widget.user.photoUrl),
              ),
            ),
          ),
          Text(widget.user.username),
        ],
      );
}
