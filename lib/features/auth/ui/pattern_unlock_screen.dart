import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';

class PatternUnlockScreen extends StatefulWidget {
  final String savedPattern;

  const PatternUnlockScreen({
    super.key,
    required this.savedPattern,
  });

  @override
  State<PatternUnlockScreen> createState() => _PatternUnlockScreenState();
}

class _PatternUnlockScreenState extends State<PatternUnlockScreen> {
  String message = 'Draw your pattern';

  void onPatternComplete(List<int> pattern) {
    final input = pattern.join('-');

    if (input == widget.savedPattern) {
      Navigator.pop(context, true);
    } else {
      setState(() {
        message = 'Wrong pattern';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unlock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const SizedBox(height: 24),
            SizedBox(
              height: 280,
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