import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';

class PatternSetupScreen extends StatefulWidget {
  const PatternSetupScreen({super.key});

  @override
  State<PatternSetupScreen> createState() => _PatternSetupScreenState();
}

class _PatternSetupScreenState extends State<PatternSetupScreen> {
  List<int>? firstPattern;
  String message = 'Draw a new pattern';

  void onPatternComplete(List<int> pattern) {
    if (pattern.length < 4) {
      setState(() {
        message = 'Use at least 4 dots';
      });
      return;
    }

    if (firstPattern == null) {
      setState(() {
        firstPattern = List<int>.from(pattern);
        message = 'Draw the pattern again to confirm';
      });
      return;
    }

    final same =
        firstPattern!.length == pattern.length &&
        firstPattern!.asMap().entries.every((e) => e.value == pattern[e.key]);

    if (!same) {
      setState(() {
        firstPattern = null;
        message = 'Patterns did not match. Start again';
      });
      return;
    }

    Navigator.pop(context, pattern.join('-'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Pattern'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
		  mainAxisAlignment: MainAxisAlignment.center,
		  children: [
			Text(
			  message,
			  style: const TextStyle(fontSize: 16),
			  textAlign: TextAlign.center,
			),
			const SizedBox(height: 32),
			SizedBox(
			  height: 320,
			  child: PatternLock(
				selectedColor: Colors.blue,
				notSelectedColor: Colors.grey,
				pointRadius: 10,
				onInputComplete: onPatternComplete,
			  ),
			),
		  ],
		),
      ),
    );
  }
}