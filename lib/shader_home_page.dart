import 'dart:async';
import 'dart:ui';

import 'package:demos/shader_painter.dart';
import 'package:flutter/material.dart';

class ShaderHomePage extends StatefulWidget {
  const ShaderHomePage({super.key});

  @override
  State<ShaderHomePage> createState() => _ShaderHomePageState();
}

class _ShaderHomePageState extends State<ShaderHomePage> {
  late Timer timer;
  double delta = 0;
  FragmentShader? shader;

  void loadMyShader() async {
    var program = await FragmentProgram.fromAsset('shaders/shader.frag');
    shader = program.fragmentShader();
    setState(() {});

    timer = Timer.periodic(
      const Duration(milliseconds: 16),
      (timer) => setState(() => delta += 1 / 60),
    );
  }

  @override
  void initState() {
    super.initState();
    loadMyShader();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => shader == null
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : CustomPaint(
          painter: ShaderPainter(shader!, delta),
        );
}
