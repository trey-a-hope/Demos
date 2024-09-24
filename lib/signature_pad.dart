import 'package:flutter/material.dart';

class SignaturePad extends StatefulWidget {
  const SignaturePad({super.key});

  @override
  State createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  // 1. Display a Signature widget.
  // 2. Clear a signature.
  // 3. Save signature.
  // 4. Display button for each saved drawing.
  // 5. Load a saved signature.
  // 6. Undo a stroke.
  // 7. Redo a stroke.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Signature Pad'),
          centerTitle: false,
        ),
        body: const SafeArea(
          child: Center(),
        ),
      );
}
