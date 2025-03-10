import 'package:flutter/material.dart';
import 'package:jokes_app/providers/joke_provider.dart';
import 'package:provider/provider.dart';

class LikedJokesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        title: Text("Liked Jokes"),
      ),
      body: Consumer<JokeProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.likedJokes.length,
            itemBuilder: (context, index) {
              final joke = provider.likedJokes[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(joke['setup']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(joke['punchline']!),
                      Text(
                        "Saved on: ${joke['date']!}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      provider.removeJoke(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
