import 'package:flutter/material.dart';
import 'core/db/database_helper.dart';
import 'features/vault/ui/vault_list_screen.dart';

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
      home: VaultListScreen(),
    );
  }
}