import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_picker/file_picker.dart';

import 'security_screen.dart';
import '../../vault/data/vault_repository.dart';
import 'vault_word_screen.dart';
import '../../../core/db/database_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final repo = VaultRepository();

  static const Color _bgColor = Color(0xFF020617);
  static const Color _cardColor = Color(0xFF0F172A);
  static const Color _primary = Color(0xFF22D3EE);
  static const Color _textPrimary = Color(0xFFE2E8F0);
  static const Color _textSecondary = Color(0xFF94A3B8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _bgColor,
        surfaceTintColor: _bgColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Item(
            title: "Security",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SecurityScreen(),
                ),
              );
            },
          ),
          _Item(
            title: "Export Data",
            onTap: exportPlaceholder,
          ),
          _Item(
            title: "Import Data",
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
          _Item(
            title: "Vault Word",
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VaultWordScreen(),
                ),
              );

              if (result == true) {
                setState(() {});
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

class _Item extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _Item({
    required this.title,
    required this.onTap,
  });

  static const Color _cardColor = Color(0xFF0F172A);
  static const Color _primary = Color(0xFF22D3EE);
  static const Color _textPrimary = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: _primary,
        ),
        onTap: onTap,
      ),
    );
  }
}