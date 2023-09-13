import 'package:flutter/material.dart';
import 'dart:async';
import 'stopwatch_card.dart'; // Import the StopwatchCard from the new file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> stopwatchNames = ['Stopwatch 1'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // Add your info button action here
              _showInfoDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: stopwatchNames.length,
        itemBuilder: (context, index) {
          return Center(
            child: StopwatchCard(
              name: stopwatchNames[index],
              onNameChanged: (newName) {
                setState(() {
                  stopwatchNames[index] = newName;
                });
              },
              onDelete: () {
                setState(() {
                  stopwatchNames.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            stopwatchNames.add('Stopwatch ${stopwatchNames.length + 1}');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Define the function to show the info dialog
  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('App Info'),
          content: Text('This is a Multi Stopwatch App.⌚ \n\nYou can Add➕, Rename🖊️ and Delete🗑️ the stopwatch.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

