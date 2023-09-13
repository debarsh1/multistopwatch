import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchCard extends StatefulWidget {
  final String name;
  final Function(String) onNameChanged;
  final VoidCallback onDelete;

  StopwatchCard({
    required this.name,
    required this.onNameChanged,
    required this.onDelete,
  });

  @override
  _StopwatchCardState createState() => _StopwatchCardState();
}

class _StopwatchCardState extends State<StopwatchCard> {
  final Stopwatch _stopwatch = Stopwatch();
  bool _isRunning = false;
  late Timer _timer;

  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              widget.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditDialog();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.onDelete(); // Call the onDelete callback
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              _formatTime(_stopwatch.elapsedMilliseconds),
              style: TextStyle(fontSize: 48),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_isRunning) {
                      _stopwatch.stop();
                      _isRunning = false;
                      _timer.cancel();
                    } else {
                      _stopwatch.start();
                      _isRunning = true;
                      _startTimer();
                    }
                  });
                },
                child: Text(_isRunning ? 'Pause' : 'Start'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _stopwatch.reset();
                  });
                },
                child: Text('Reset'),
              ),
            ],
          ),
          SizedBox(height: 16), // Add spacing here
        ],
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isRunning) {
        timer.cancel();
      } else {
        setState(() {});
      }
    });
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).floor();
    int minutes = (seconds / 60).floor();
    int hours = (minutes / 60).floor();

    String hoursStr = (hours % 24).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Stopwatch Name'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'New Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                widget.onNameChanged(_nameController.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
