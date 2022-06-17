import 'package:flutter/material.dart';
import 'package:project2/viewscreen/game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Image Chooser',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: GameScreen.routeName,
        routes: {
          GameScreen.routeName: (BuildContext context) => const GameScreen(),
        });
  }
}
