import 'package:flutter/material.dart';
import 'package:jokes_app/providers/joke_provider.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "Joke App",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("User Name"),
              accountEmail: Text("user@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.blueGrey),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            ListTile(
              tileColor: Colors.blue.shade100,
              title: Text("Liked Jokes"),
              onTap: () {
                Navigator.pushNamed(context, "likedJokes");
              },
            ),
          ],
        ),
      ),
      body: Consumer<JokeProvider>(
        builder: (context, provider, child) {
          return Center(
            child:
                provider.isLoading
                    ? CircularProgressIndicator()
                    : provider.joke != null
                    ? Card(
                      elevation: 4,
                      margin: EdgeInsets.all(16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              provider.joke!.setup,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              provider.joke!.punchline,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : Text("No joke available"),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed:
                () =>
                    Provider.of<JokeProvider>(
                      context,
                      listen: false,
                    ).fetchJoke(),
            child: Icon(Icons.refresh),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed:
                () =>
                    Provider.of<JokeProvider>(
                      context,
                      listen: false,
                    ).likeJoke(),
            icon: Icon(Icons.favorite),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed:
                () =>
                    Provider.of<JokeProvider>(
                      context,
                      listen: false,
                    ).shareJoke(),
            icon: Icon(Icons.share),
          ),
        ],
      ),
    );
  }
}
