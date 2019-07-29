import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(          // Add the 3 lines from here...
        primaryColor: Colors.green,
      ),
      home: Scaffold(
        body: Center(
          child: WordsListWidget(),
        ),
      ),
    );
  }
}

class WordsListWidget extends StatefulWidget {
  @override
  WordsListWidgetState createState() => WordsListWidgetState();
}

class WordsListWidgetState extends State<WordsListWidget> {
  final _suggestions = <String>[];
  final Set<String> _saved = Set<String>();   //
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Flutter"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _goToFavorite)
        ],
      ),
      body: _buildSuggestions(),

    );
  }

  void _goToFavorite(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(   // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (String string) {
              return ListTile(
                title: Text(
                  string,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();

          return Scaffold(         // Add 6 lines from here...
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),                       // ... to here.
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        itemCount: 8,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.add("test1");
            _suggestions.add("test2");
            _suggestions.add("test3");
            _suggestions.add("test4");
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildFavorites() {
    return ListView.builder(
        itemCount: 8,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.add("test1");
            _suggestions.add("test2");
            _suggestions.add("test3");
            _suggestions.add("test4");
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(String string) {
    final bool alreadySaved = _saved.contains(string);
    return ListTile(
      title: Text(
        string,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {      // Add 9 lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(string);
          } else {
            _saved.add(string);
          }
        });
      },
    );
  }
}
