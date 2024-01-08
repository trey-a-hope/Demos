import 'package:demos/example_1/home_page.dart';
import 'package:demos/example_2/weather_page.dart';
import 'package:demos/example_5/films_page.dart';
import 'package:demos/example_4/person_page.dart';
import 'package:demos/example_3/time_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// https://www.youtube.com/watch?v=vtGCteFYs4M&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&start_radio=1

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
              isScrollable: true,
              tabs: [
                Tab(text: 'Home Example'),
                Tab(text: 'Weather Example'),
                Tab(text: 'Time Example'),
                Tab(text: 'People Example'),
                Tab(text: 'Films Example'),
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
