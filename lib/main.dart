import 'package:flutter/material.dart';
import 'package:jokes_app/Views/Screens/homescreen.dart';
import 'package:jokes_app/Views/Screens/liked_jokes.dart';
import 'package:jokes_app/Views/Screens/splash_screen.dart';

import 'package:jokes_app/providers/joke_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isSplashScreenVisited = pref.getBool('issplashscreenvisited') ?? false;

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => JokeProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: isSplashScreenVisited ? '/' : 'splash',
        routes: {
          "/": (context) => Homescreen(),
          "splash": (context) => SplashScreen(),
          "likedJokes": (context) => LikedJokesPage(),
        },
      ),
    ),
  );
}
