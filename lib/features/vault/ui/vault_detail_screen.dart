import 'package:flutter/material.dart';
import '../models/vault_item.dart';
import 'add_edit_screen.dart';

class VaultDetailScreen extends StatelessWidget {
  final VaultItem item;

  const VaultDetailScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(item.title),
  actions: [
    IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddEditScreen(
              initialData: {
                "title": item.title,
                "username": item.username,
                "password": item.password,
                "note": item.note,
              },
            ),
          ),
        );

        if (result != null) {
          Navigator.pop(context, result);
        }
      },
    )
  ],
),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InfoTile(
            label: 'Title',
            value: item.title,
          ),
          _InfoTile(
            label: 'Username',
            value: item.username,
          ),
          _InfoTile(
            label: 'Password',
            value: item.password,
          ),
          _InfoTile(
            label: 'Note',
            value: item.note.isEmpty ? '-' : item.note,
          ),
          _InfoTile(
            label: 'Last Changed',
            value: _formatTs(item.lastChangedAt),
          ),
          _InfoTile(
            label: 'Created',
            value: _formatTs(item.createdAt),
          ),
          _InfoTile(
            label: 'Updated',
            value: _formatTs(item.updatedAt),
          ),
        ],
      ),
    );
  }

  static String _formatTs(int ts) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ts);
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$d.$m.$y  $h:$min';
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}