import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/vault_item.dart';
import 'add_edit_screen.dart';

class VaultDetailScreen extends StatelessWidget {
  final VaultItem item;
  final bool shouldHide;

  const VaultDetailScreen({
    super.key,
    required this.item,
    required this.shouldHide,
  });

  @override
  Widget build(BuildContext context) {
    final maskedTitle =
        shouldHide ? randomFakeText() : (item.title.isEmpty ? 'Entry Details' : item.title);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          maskedTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        centerTitle: true,
        actions: [
          if (!shouldHide)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
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
                        "iban": item.iban,
                        "type": item.type,
                      },
                    ),
                  ),
                );

                if (result != null) {
                  Navigator.pop(context, result);
                }
              },
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          _HeaderCard(
            item: item,
            shouldHide: shouldHide,
          ),
          const SizedBox(height: 14),

          if (item.type == "standard") ...[
            if (shouldHide) ...[
              _InfoCard(
                label: 'Username',
                value: randomFakeText(),
              ),
              if (item.iban.isNotEmpty) ...[
                const SizedBox(height: 12),
                _InfoCard(
                  label: 'IBAN',
                  value: randomFakeText(),
                ),
              ],
              const SizedBox(height: 12),
              _InfoCard(
                label: 'Password',
                value: randomFakeText(),
              ),
              const SizedBox(height: 12),
            ] else ...[
              _CopyTile(
                label: 'Username',
                value: item.username,
                snackText: 'Username copied',
              ),
              if (item.iban.isNotEmpty) ...[
                const SizedBox(height: 12),
                _CopyTile(
                  label: 'IBAN',
                  value: item.iban,
                  snackText: 'IBAN copied',
                ),
              ],
              const SizedBox(height: 12),
              _PasswordTile(password: item.password),
              const SizedBox(height: 12),
            ],
          ],

          _InfoCard(
            label: 'Note',
            value: shouldHide
                ? randomFakeText()
                : (item.note.isEmpty ? 'No note added' : item.note),
          ),
          const SizedBox(height: 12),
          _MetaCard(item: item),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final VaultItem item;
  final bool shouldHide;

  const _HeaderCard({
    required this.item,
    required this.shouldHide,
  });

  @override
  Widget build(BuildContext context) {
    final avatarChar =
        shouldHide ? '?' : (item.title.isNotEmpty ? item.title[0] : '?').toUpperCase();

    final titleText =
        shouldHide ? randomFakeText() : (item.title.isEmpty ? 'Untitled Entry' : item.title);

    final usernameText =
        shouldHide ? randomFakeText() : (item.username.isEmpty ? 'No username' : item.username);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFF22D3EE).withOpacity(0.12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  avatarChar,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF22D3EE),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    usernameText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.65),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CopyTile extends StatelessWidget {
  final String label;
  final String value;
  final String snackText;

  const _CopyTile({
    required this.label,
    required this.value,
    required this.snackText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value.isEmpty ? '-' : value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy_rounded),
                  onPressed: value.isEmpty
                      ? null
                      : () {
                          Clipboard.setData(ClipboardData(text: value));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(snackText)),
                          );
                        },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordTile extends StatefulWidget {
  final String password;

  const _PasswordTile({required this.password});

  @override
  State<_PasswordTile> createState() => _PasswordTileState();
}

class _PasswordTileState extends State<_PasswordTile> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    hidden ? '••••••••' : widget.password,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy_rounded),
                  onPressed: widget.password.isEmpty
                      ? null
                      : () {
                          Clipboard.setData(
                            ClipboardData(text: widget.password),
                          );
                          setState(() {
                            hidden = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Password copied')),
                          );
                        },
                ),
                IconButton(
                  icon: Icon(
                    hidden ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                  ),
                  onPressed: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const _InfoCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaCard extends StatelessWidget {
  final VaultItem item;

  const _MetaCard({required this.item});

  String _formatTs(int ts) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ts);
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$d.$m.$y  $h:$min';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 10),
            _MetaRow(label: 'Created', value: _formatTs(item.createdAt)),
            const SizedBox(height: 10),
            _MetaRow(label: 'Modified', value: _formatTs(item.updatedAt)),
          ],
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetaRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

String randomFakeText() {
  final fake = [
    "system buffer",
    "encrypted block",
    "null segment",
    "hidden layer",
    "data masked",
  ];
  fake.shuffle();
  return fake.first;
}