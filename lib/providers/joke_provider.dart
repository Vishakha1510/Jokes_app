import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jokes_app/helper/jokes_helper.dart';
import 'package:jokes_app/models/joke_model.dart';
import 'package:share_plus/share_plus.dart';

class JokeProvider with ChangeNotifier {
  Joke? joke;
  List<Map<String, String>> likedJokes = [];
  bool isLoading = false;

  JokeProvider() {
    fetchJoke();
    loadLikedJokes();
  }

  Future<void> fetchJoke() async {
    isLoading = true;
    notifyListeners();

    joke = await ApiHelper.apiHelper.fetchJokes();

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadLikedJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedJokes = prefs.getStringList('likedJokes');

    if (storedJokes != null) {
      likedJokes =
          storedJokes.map((item) {
            final Map<String, dynamic> decoded = jsonDecode(item);
            return {
              'setup': decoded['setup'].toString(),
              'punchline': decoded['punchline'].toString(),
              'date': decoded['date'].toString(),
            };
          }).toList();
    } else {
      likedJokes = [];
    }

    notifyListeners();
  }

  Future<void> likeJoke() async {
    if (joke != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? storedJokes = prefs.getStringList('likedJokes') ?? [];

      Map<String, String> savedJoke = {
        'setup': joke!.setup,
        'punchline': joke!.punchline,
        'date': DateTime.now().toString(),
      };

      storedJokes.add(jsonEncode(savedJoke));
      await prefs.setStringList('likedJokes', storedJokes);

      likedJokes.add(savedJoke);
      notifyListeners();
    }
  }

  Future<void> removeJoke(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedJokes = prefs.getStringList('likedJokes');

    if (storedJokes != null && index >= 0 && index < storedJokes.length) {
      storedJokes.removeAt(index);
      await prefs.setStringList('likedJokes', storedJokes);

      likedJokes.removeAt(index);
      notifyListeners();
    }
  }

  void shareJoke() {
    if (joke != null) {
      String jokeText = "${joke!.setup}\n${joke!.punchline}";
      Share.share(jokeText);
    }
  }
}
