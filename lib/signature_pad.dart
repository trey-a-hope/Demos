import 'package:flutter/material.dart';

class SignaturePad extends StatefulWidget {
  const SignaturePad({super.key});

  @override
  State createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  // 1. Display a Signature widget.
  // 2. Clear a signature.
  // 3. Save signatures.
  // 4. Load a saved signature.
  // 5. Undo a stroke.
  // 6. Redo a stroke.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Signature Pad'),
        ),
        body: const SafeArea(
          child: Center(),
        ),
      );
}
