import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'dart:convert';


import 'security_screen.dart';
import '../../vault/data/vault_repository.dart';
import '../../../core/db/database_helper.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {

  final repo = VaultRepository(); 
  
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
ListTile(
  title: const Text("Export Data"),
  trailing: const Icon(Icons.chevron_right),
  onTap: exportPlaceholder,
),	
	
  ],
),
    );
  }
  
Future<void> exportPlaceholder() async {
	final db = await DatabaseHelper.instance.database;
	final rows = await db.query('vault');
	final collectionRows = await db.query('collections');
	final jsonString = jsonEncode({
	  "vault": rows,
	  "collections": collectionRows,
	});
	
	await FileSaver.instance.saveAs(
	  name: "lynra_backup",
	  bytes: utf8.encode(jsonString),
	  ext: "json",
	  mimeType: MimeType.json,
	);
	
	ScaffoldMessenger.of(context).showSnackBar(
	  const SnackBar(content: Text("Export coming next")),
	);
 }  
}