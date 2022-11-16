import 'package:demos/my_game.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final MyGame game = MyGame();

  runApp(
    GameWidget(game: game),
  );
}

//https://docs.flame-engine.org/1.4.0/flame/router.html