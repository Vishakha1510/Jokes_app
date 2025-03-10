import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jokes_app/models/joke_model.dart';

class ApiHelper {
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();

  String api = "https://official-joke-api.appspot.com/random_joke";

  Future<Joke> fetchJokes() async {
    http.Response res = await http.get(Uri.parse(api));
    if (res.statusCode == 200) {
      Map decodeddata = jsonDecode(res.body);

      return Joke(
        type: decodeddata['type'],
        setup: decodeddata['setup'],
        punchline: decodeddata['punchline'],
      );
    } else
      throw Exception("Failed to load");
  }
}
