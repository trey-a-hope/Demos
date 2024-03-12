import 'package:demos/constants/globals.dart';
import 'package:demos/demo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Gemini.init(
    apiKey: Globals.googleAIStudioAPIKey,
    enableDebugging: true,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DemoPage(),
        theme: ThemeData(
          textTheme: GoogleFonts.comfortaaTextTheme(),
        ),
      );
}
