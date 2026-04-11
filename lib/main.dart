import 'package:flutter/material.dart';
import 'core/db/database_helper.dart';
import 'features/auth/ui/pattern_setup_screen.dart';
import 'features/auth/ui/pattern_unlock_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(const LynraApp());
}

class LynraApp extends StatelessWidget {
  const LynraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PatternFlow(),
    );
  }
}

class PatternFlow extends StatefulWidget {
  const PatternFlow({super.key});

  @override
  State<PatternFlow> createState() => _PatternFlowState();
}

class _PatternFlowState extends State<PatternFlow> {
  String? savedPattern;

  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    start();
  });
}

  Future<void> start() async {
    final pattern = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PatternSetupScreen()),
    );

    if (pattern == null) return;

    savedPattern = pattern;

    final unlocked = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PatternUnlockScreen(savedPattern: savedPattern!),
      ),
    );

    if (unlocked == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (savedPattern == null) {
      return const Scaffold(body: SizedBox());
    }

    return const Scaffold(
      body: Center(
        child: Text("Unlocked"),
      ),
    );
  }
}