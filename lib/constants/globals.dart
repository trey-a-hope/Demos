import 'package:demos/models/fruit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Globals {
  Globals._();

  static const googleAIStudioAPIKey = 'AIzaSyAfnQqSJeljb4_g-CmweqsiQ_fDXxkPTfk';

  /// Fruits
  static final fruits = <Fruit>[
    Fruit(
      name: 'Apple',
      color: Colors.pink,
      lottie: lottieApple,
    ),
    Fruit(
      name: 'Banana',
      color: Colors.yellow.shade700,
      lottie: lottieBanana,
    ),
    Fruit(
      name: 'Blueberry',
      color: Colors.blueGrey.shade700,
      lottie: lottieBlueberry,
    ),
    Fruit(
      name: 'Cherries',
      color: Colors.red.shade900,
      lottie: lottieCherries,
    ),
    Fruit(
      name: 'Coconut',
      color: Colors.brown.shade700,
      lottie: lottieCoconut,
    ),
    Fruit(
      name: 'Kiwi',
      color: Colors.green.shade700,
      lottie: lottieKiwi,
    ),
    Fruit(
      name: 'Mangosteen',
      color: Colors.purple.shade900,
      lottie: lottieMangosteen,
    ),
    Fruit(
      name: 'Papaya',
      color: Colors.pink.shade700,
      lottie: lottiePapaya,
    ),
    Fruit(
      name: 'Peach',
      color: Colors.pink.shade700,
      lottie: lottiePeach,
    ),
    Fruit(
      name: 'Pear',
      color: Colors.green.shade700,
      lottie: lottiePear,
    ),
  ];

  /// Lottie Files - Fruit
  static final lottieApple = Lottie.asset(
    'assets/apple.json',
    width: 300,
    height: 300,
  );

  static final lottieBanana = Lottie.asset(
    'assets/banana.json',
    width: 300,
    height: 300,
  );

  static final lottieBlueberry = Lottie.asset(
    'assets/blueberry.json',
    width: 300,
    height: 300,
  );

  static final lottieCherries = Lottie.asset(
    'assets/cherries.json',
    width: 300,
    height: 300,
  );

  static final lottieCoconut = Lottie.asset(
    'assets/coconut.json',
    width: 300,
    height: 300,
  );

  static final lottieFruitBasket = Lottie.asset(
    'assets/fruit_basket.json',
    width: 300,
    height: 300,
  );

  static final lottieKiwi = Lottie.asset(
    'assets/kiwi.json',
    width: 300,
    height: 300,
  );

  static final lottieMangosteen = Lottie.asset(
    'assets/mangosteen.json',
    width: 300,
    height: 300,
  );

  static final lottiePapaya = Lottie.asset(
    'assets/papaya.json',
    width: 300,
    height: 300,
  );

  static final lottiePeach = Lottie.asset(
    'assets/peach.json',
    width: 300,
    height: 300,
  );

  static final lottiePear = Lottie.asset(
    'assets/pear.json',
    width: 300,
    height: 300,
  );
}
