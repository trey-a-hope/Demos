import 'package:demos/models/fruit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Globals {
  Globals._();

  /// API Keys
  static const googleAIStudioAPIKey = 'AIzaSyAfnQqSJeljb4_g-CmweqsiQ_fDXxkPTfk';

  /// Fruits
  static final fruits = <Fruit>[
    Fruit(
      name: 'Banana',
      color: Colors.yellow.shade700,
      lottie: lottieBanana,
    ),
    Fruit(
      name: 'Apple',
      color: Colors.pink,
      lottie: lottieApple,
    )
  ];

  /// Lottie Files - Fruit
  static final lottieFruitBasket = Lottie.asset(
    'assets/fruit_basket.json',
    width: 300,
    height: 300,
  );

  static final lottieBanana = Lottie.asset(
    'assets/banana.json',
    width: 300,
    height: 300,
  );

  static final lottieApple = Lottie.asset(
    'assets/banana.json',
    width: 300,
    height: 300,
  );
}
