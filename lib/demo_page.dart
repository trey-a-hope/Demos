import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:demos/my_assets/resources.dart';
import 'package:flutter/material.dart';

/*
   10. Display list of images and audio.
*/

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});
  @override
  State createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spider'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: Images.values.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage(Images.values[index]),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < Sounds.values.length; i++) ...[
                  GestureDetector(
                    onTap: () => AssetsAudioPlayer.newPlayer().open(
                      Audio(Sounds.values[i]),
                    ),
                    child: const CircleAvatar(
                      child: Icon(
                        Icons.play_arrow,
                      ),
                    ),
                  )
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
