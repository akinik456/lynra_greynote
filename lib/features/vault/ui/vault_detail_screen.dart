import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';
import 'package:path_provider/path_provider.dart';

import '../models/vault_item.dart';
import 'add_edit_screen.dart';
import 'package:cryptography/cryptography.dart';
import '../../../core/security/crypto_helper.dart';
import 'package:open_filex/open_filex.dart';

import '../../../l10n/app_localizations.dart';
import '../../../core/attachments/attachment_service.dart';
import '../data/vault_repository.dart';

class VaultDetailScreen extends StatelessWidget {
  final VaultItem item;
  final bool shouldHide;
	final SecretKey payloadKey;
	
  const VaultDetailScreen({
    super.key,
    required this.item,
    required this.shouldHide,
		required this.payloadKey,
  });

  @override
  Widget build(BuildContext context) {
    final pageTitle =
        shouldHide ? randomFakeText() : (item.title.isEmpty ? AppLocalizations.of(context)!.entryDetails : item.title);

    return Scaffold(
	backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
	    backgroundColor: const Color(0xFF020617), // 👈 EKLE
  surfaceTintColor: const Color(0xFF020617), // 👈 EKLE (çok önemli)
  elevation: 0,
        title: Text(
          pageTitle,
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
          if (item.type == "standard") ...[
            if (shouldHide) ...[
              _InfoCard(
                label: AppLocalizations.of(context)!.username,
                value: randomFakeText(),
              ),
              if (item.iban.isNotEmpty) ...[
                const SizedBox(height: 12),
                _InfoCard(
                  label: AppLocalizations.of(context)!.iban,
                  value: randomFakeText(),
                ),
              ],
              const SizedBox(height: 12),
              _InfoCard(
                label: AppLocalizations.of(context)!.password,
                value: randomFakeText(),
              ),
              const SizedBox(height: 12),
            ] else ...[
              _CopyTile(
                label: AppLocalizations.of(context)!.username,
                value: item.username,
                snackText: AppLocalizations.of(context)!.usernameCopied,
              ),
              if (item.iban.isNotEmpty) ...[
                const SizedBox(height: 12),
                _CopyTile(
                  label: AppLocalizations.of(context)!.iban,
                  value: item.iban,
                  snackText: AppLocalizations.of(context)!.ibanCopied,
                ),
              ],
              const SizedBox(height: 12),
              _PasswordTile(password: item.password),
              const SizedBox(height: 12),
            ],
          ],
					if (item.hasAttachment) ...[
  Row(
    children: [
      Expanded(
        child: SizedBox(
          height: 36,
          child: OutlinedButton.icon(
            onPressed: () async {
              final service = AttachmentService();

              final data = await service.readEncryptedAttachment(
                itemId: item.id,
                key: payloadKey,
              );

              if (data == null) return;

              final type = data['type'];
              final base64Data = data['data'];
              final bytes = base64Decode(base64Data);

              if (type == 'image') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      backgroundColor: Colors.black,
                      appBar: AppBar(backgroundColor: Colors.black),
                      body: Center(
                        child: Image.memory(bytes),
                      ),
                    ),
                  ),
                );
                return;
              }              
              if (type == 'pdf') {
								final dir = await getTemporaryDirectory();
								final file = File('${dir.path}/${item.id}.pdf');

								await file.writeAsBytes(bytes, flush: true);

								await OpenFilex.open(file.path);
							}
            },
            icon: const Icon(Icons.attach_file, size: 18),
            label: Text(AppLocalizations.of(context)!.viewAttachment),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white.withOpacity(0.6)),
              foregroundColor: const Color(0xFF22D3EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),

      const SizedBox(width: 12),

      TextButton.icon(
        onPressed: () async {
          final service = AttachmentService();
          final repo = VaultRepository();

          await service.deleteAttachment(item.id);

          await repo.setHasAttachment(
            itemId: item.id,
            hasAttachment: false,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
							content: Text(AppLocalizations.of(context)!.attachmentRemoved),
						),
          );

          Navigator.pop(context, true);
        },
        icon: const Icon(Icons.delete, color: Colors.red, size: 18),
        label: Text(
  AppLocalizations.of(context)!.removeAttachment,
  style: const TextStyle(color: Colors.red),
),
      ),
    ],
  ),
],
					
					const SizedBox(height: 12),
          _InfoCard(
            label: AppLocalizations.of(context)!.note,
            value: shouldHide
                ? randomFakeText()
                : (item.note.isEmpty ? AppLocalizations.of(context)!.noNoteAdded : item.note),
          ),
					if (item.type == "pattern" && item.pattern.isNotEmpty) ...[
						const SizedBox(height: 12),
						_PatternViewCard(pattern: shouldHide ? "" : item.pattern),
					],					
          const SizedBox(height: 12),
          _MetaCard(item: item),
        ],
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
    return _CardWrapper(
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
    return _CardWrapper(
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
                          SnackBar(content: Text(AppLocalizations.of(context)!.passwordCopied)),
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
    return _CardWrapper(
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
    return _CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.details,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 10),
          _MetaRow(label: AppLocalizations.of(context)!.created, value: _formatTs(item.createdAt)),
          const SizedBox(height: 10),
          _MetaRow(label: AppLocalizations.of(context)!.modified, value: _formatTs(item.updatedAt)),
        ],
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

class _CardWrapper extends StatelessWidget {
  final Widget child;

  const _CardWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: child,
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

class _PatternViewCard extends StatelessWidget {
  final String pattern;

  const _PatternViewCard({
    required this.pattern,
  });

  @override
  Widget build(BuildContext context) {
    return _CardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pattern",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 12),
          _PatternViewer(pattern: pattern),
        ],
      ),
    );
  }
}

class _PatternViewer extends StatelessWidget {
  final String pattern;

  const _PatternViewer({
    required this.pattern,
  });

  List<int> _parsePattern() {
    return pattern
        .split('-')
        .map((e) => int.tryParse(e.trim()))
        .whereType<int>()
        .where((e) => e >= 1 && e <= 9)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final selected = _parsePattern();

    return SizedBox(
      height: 260,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          final gridSize = min(size.width, size.height) * 0.76;
          final left = (size.width - gridSize) / 2;
          final top = (size.height - gridSize) / 2;

          final centers = List.generate(9, (index) {
            final row = index ~/ 3;
            final col = index % 3;

            return Offset(
              left + (gridSize / 2) * col,
              top + (gridSize / 2) * row,
            );
          });

          return CustomPaint(
            painter: _PatternViewPainter(
              selected: selected,
              centers: centers,
            ),
            child: Stack(
              children: List.generate(9, (index) {
                final number = index + 1;
                final center = centers[index];
                final isSelected = selected.contains(number);

                return Positioned(
                  left: center.dx - 22,
                  top: center.dy - 22,
                  width: 44,
                  height: 44,
                  child: Center(
                    child: Container(
                      width: isSelected ? 20 : 14,
                      height: isSelected ? 20 : 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? const Color(0xFF22D3EE)
                            : const Color(0xFF94A3B8).withOpacity(0.45),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF22D3EE).withOpacity(0.35),
                                  blurRadius: 14,
                                  spreadRadius: 2,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

class _PatternViewPainter extends CustomPainter {
  final List<int> selected;
  final List<Offset> centers;

  const _PatternViewPainter({
    required this.selected,
    required this.centers,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (selected.isEmpty || centers.length != 9) return;

    final paint = Paint()
      ..color = const Color(0xFF22D3EE).withOpacity(0.75)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < selected.length - 1; i++) {
      final from = centers[selected[i] - 1];
      final to = centers[selected[i + 1] - 1];
      canvas.drawLine(from, to, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PatternViewPainter oldDelegate) {
    return oldDelegate.selected != selected || oldDelegate.centers != centers;
  }
}