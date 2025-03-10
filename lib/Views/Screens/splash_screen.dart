import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 300,
                width: 250,
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2016/03/31/20/27/actor-1295772_1280.png",
                  fit: BoxFit.cover,
                ),
              ),
              LinearProgressIndicator(),
              TextButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();

                  pref.setBool("issplashscreenvisited", true);

                  Navigator.of(context).pushReplacementNamed("/");
                },
                child: Text("Tap for Instant LOLs! 😂👉"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
