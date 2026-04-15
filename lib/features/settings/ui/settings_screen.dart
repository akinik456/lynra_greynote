import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_picker/file_picker.dart';


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
ListTile(
  title: const Text("Import Data"),
  trailing: const Icon(Icons.chevron_right),
  onTap: () async {
  final result = await FilePicker.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['json'],
  );

  if (result != null) {
  final path = result.files.single.path;
  final file = File(path!);
  final content = await file.readAsString();
  final data = jsonDecode(content);
  final vaultRows = data["vault"];
  final collectionRows = data["collections"];
  final db = await DatabaseHelper.instance.database;
  await db.delete('vault');
  await db.delete('collections');
	  for (final row in collectionRows) {
	  await db.insert('collections', Map<String, dynamic>.from(row));
	  }
	  for (final row in vaultRows) {
	  await db.insert('vault', Map<String, dynamic>.from(row));
	  }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Import completed")),
    );
  }
},
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