import 'package:demos/pages/files_page.dart';
import 'package:demos/pages/person_page.dart';
import 'package:demos/pages/home_page.dart';
import 'package:demos/pages/time_page.dart';
import 'package:demos/pages/weather_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// https://github.com/vandadnp/youtube-riverpodcourse-public/tree/main

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const pages = [
    HomePage(),
    WeatherPage(),
    TimePage(),
    PersonPage(),
    FilmsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: pages.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Home'),
                Tab(text: 'Weather'),
                Tab(text: 'Time'),
                Tab(text: 'People'),
                Tab(text: 'Films'),
              ],
            ),
            title: const Text('Riverpod Demo'),
          ),
          body: const TabBarView(children: pages),
        ),
      ),
    );
  }
}
