import 'package:flutter/material.dart';
import 'security_screen.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
  padding: const EdgeInsets.all(16),
  children: [
    ListTile(
      title: const Text("Security"),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const SecurityScreen(),
    ),
  );
},
    ),
  ],
),
    );
  }
}