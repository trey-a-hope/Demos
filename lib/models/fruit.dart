import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Fruit {
  final String name;
  final Color color;
  final LottieBuilder lottie;

  Fruit({
    required this.name,
    required this.color,
    required this.lottie,
  });
}
