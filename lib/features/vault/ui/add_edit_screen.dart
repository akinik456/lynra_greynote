import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';
import 'package:file_picker/file_picker.dart';

import '../../../l10n/app_localizations.dart';
import '../../../core/attachments/attachment_service.dart';
import '../data/vault_repository.dart';
import '../../../core/security/crypto_helper.dart';
import '../../../main.dart';


class AddEditScreen extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const AddEditScreen({
    super.key,
    this.initialData,
  });

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final titleCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  final ibanCtrl = TextEditingController();

  bool showBankDetails = false;
  bool hidePassword = true;
  String entryType = "standard";
  String passwordStrengthKey  = "";
  String generatedPassword = "";
	Uint8List? _attachmentBytes;
	String? _attachmentType;
	String? patternValue;
  
  static const Color _bgColor = Color(0xFF020617);
  static const Color _cardColor = Color(0xFF0F172A);
  static const Color _primary = Color(0xFF22D3EE);
  static const Color _textPrimary = Color(0xFFE2E8F0);
  static const Color _textSecondary = Color(0xFF94A3B8);

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
		titleCtrl.text = widget.initialData!["title"] ?? "";
		usernameCtrl.text = widget.initialData!["username"] ?? "";
		passwordCtrl.text = widget.initialData!["password"] ?? "";
		noteCtrl.text = widget.initialData!["note"] ?? "";
		patternValue = widget.initialData!["pattern"];
    }
	ibanCtrl.text = widget.initialData?["iban"] ?? "";
	showBankDetails = ibanCtrl.text.trim().isNotEmpty;
	entryType =  widget.initialData?["type"] ?? "standard";
	updatePasswordStrength(passwordCtrl.text);
  }

  String generatePassword({int length = 10}) {
	const chars =
	'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#\$%&*_-';
	final random = Random.secure();
		return List.generate(
			length,
			(_) => chars[random.nextInt(chars.length)],
		).join();
  }

  void save() {
	if (entryType == "pattern" &&
    (patternValue == null || patternValue!.isEmpty)) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
			content: Text(AppLocalizations.of(context)!.drawNewPattern),
    ),
  );
  return;
}
  Navigator.pop(context, {
    "title": titleCtrl.text.trim(),
    "username": usernameCtrl.text.trim(),
    "password": passwordCtrl.text,
    "note": entryType == "pattern" ? "" : noteCtrl.text.trim(),
		"pattern": entryType == "pattern" ? (patternValue ?? "") : "",
		"iban": showBankDetails ? ibanCtrl.text.trim() : "",
		"type": entryType,
    "attachmentBytes": _attachmentBytes,
    "attachmentType": _attachmentType,
  });
}

  void updatePasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() => passwordStrengthKey = "");
      return;
    }
    int score = 0;
    if (password.length >= 8) score++;
    if (password.length >= 10) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#\$%&*_\-]').hasMatch(password)) score++;
    if (score <= 2) {
      passwordStrengthKey  = "weak";
    } else if (score <= 4) {
      passwordStrengthKey  = "medium";
    } else {
      passwordStrengthKey  = "strong";
    }
    setState(() {});
  }

@override
Widget build(BuildContext context) {
  final isEdit = widget.initialData != null;

  return Scaffold(
    backgroundColor: _bgColor,
    appBar: AppBar(
      backgroundColor: _bgColor,
      surfaceTintColor: _bgColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        isEdit
            ? AppLocalizations.of(context)!.editEntry
            : AppLocalizations.of(context)!.newEntry,
        style: const TextStyle(
          color: _textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      children: [
        Row(
          children: [
            Expanded(
              child: _TypeButton(
                label: AppLocalizations.of(context)!.standard,
                selected: entryType == "standard",
                onTap: () {
                  setState(() => entryType = "standard");
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _TypeButton(
                label: AppLocalizations.of(context)!.noteType,
                selected: entryType == "note",
                onTap: () {
                  setState(() => entryType = "note");
                },
              ),
            ),
						const SizedBox(width: 8),
						Expanded(
							child: _TypeButton(
								label: AppLocalizations.of(context)!.pattern,
								selected: entryType == "pattern",
								onTap: () {
									setState(() => entryType = "pattern");
								},
							),
						),
          ],
        ),
        const SizedBox(height: 8),

        _FieldCard(
          label: AppLocalizations.of(context)!.title,
          child: SizedBox(
            height: 18,
            child: TextField(
              controller: titleCtrl,
              maxLines: 1,
              style: const TextStyle(
                color: _textPrimary,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                hintText: AppLocalizations.of(context)!.title,
                hintStyle: const TextStyle(color: _textSecondary),
                border: InputBorder.none,
              ),
            ),
          ),
        ),

        if (entryType == "standard") ...[
          _FieldCard(
            label: AppLocalizations.of(context)!.username,
            child: SizedBox(
              height: 18,
              child: TextField(
                controller: usernameCtrl,
                maxLines: 1,
                style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                  hintText: AppLocalizations.of(context)!.usernameEmail,
                  hintStyle: const TextStyle(color: _textSecondary),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          _FieldCard(
						label: AppLocalizations.of(context)!.bankDetails,
						child: SizedBox(
							height: 24,
							child: Row(
								children: [
									Expanded(
										child: Text(
											AppLocalizations.of(context)!.addIban,
											style: const TextStyle(
												color: _textPrimary,
												fontSize: 15,
											),
										),
									),
									Transform.scale(
										scale: 0.9,
										child: Switch(
											value: showBankDetails,
											activeColor: _primary,
											onChanged: (value) {
												setState(() {
													showBankDetails = value;
													if (!showBankDetails) {
														ibanCtrl.clear();
													}
												});
											},
										),
									),
								],
							),
						),
					),
          if (showBankDetails)
            _FieldCard(
              label: AppLocalizations.of(context)!.iban,
              child: SizedBox(
                height: 20,
                child: TextField(
                  controller: ibanCtrl,
                  maxLines: 1,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 15,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    hintText: "XX00 0000 0000 0000 0000 0000 00",
                    hintStyle: TextStyle(color: _textSecondary),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

          _FieldCard(
						label: AppLocalizations.of(context)!.password,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								SizedBox(
									height: 20,
									child: Row(
										children: [
											Expanded(
												child: TextField(
													controller: passwordCtrl,
													obscureText: hidePassword,
													onChanged: updatePasswordStrength,
													maxLines: 1,
													style: const TextStyle(
														color: _textPrimary,
														fontSize: 15,
													),
													decoration: InputDecoration(
														isDense: true,
														contentPadding: const EdgeInsets.symmetric(vertical: 4),
														hintText: AppLocalizations.of(context)!.password,
														hintStyle: const TextStyle(color: _textSecondary),
														border: InputBorder.none,
													),
												),
											),
											SizedBox(
												width: 32, // burada alanı biz belirliyoruz
												child: Align(
													alignment: Alignment.centerLeft, // ikonu sola yaslar
													child: GestureDetector(
														onTap: () {
															setState(() {
																hidePassword = !hidePassword;
															});
														},
														child: Icon(
															hidePassword ? Icons.visibility : Icons.visibility_off,
															color: _textSecondary,
															size: 26,
														),
													),
												),
											),
										],
									),
								),
								if (passwordStrengthKey.isNotEmpty)
									Padding(
										padding: const EdgeInsets.only(top: 6),
										child: Text(
											passwordStrengthKey == "weak"
													? AppLocalizations.of(context)!.weak
													: passwordStrengthKey == "medium"
															? AppLocalizations.of(context)!.medium
															: passwordStrengthKey == "strong"
																	? AppLocalizations.of(context)!.strong
																	: "",
											style: TextStyle(
												color: passwordStrengthKey == "weak"
														? Colors.redAccent
														: passwordStrengthKey == "medium"
																? Colors.orangeAccent
																: Colors.greenAccent,
												fontSize: 12,
												fontWeight: FontWeight.w600,
											),
										),
									),
							],
						),
					),
          _FieldCard(
            label:"",
						child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [                
                Text(
        AppLocalizations.of(context)!.generatePasswordDescription,
        style: TextStyle(
          color: _textSecondary,
          fontSize: 13,
          height: 1.4,
        ),
      ),

      const SizedBox(height: 8),
								
								Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        final generated = generatePassword();
                        setState(() {
                          generatedPassword = generated;
                        });
                      },
                      icon: const Icon(Icons.auto_awesome, color: _primary),
                      label: Text(AppLocalizations.of(context)!.generate),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        generatedPassword.isEmpty
                            ? AppLocalizations.of(context)!
                                .noPasswordGenerated
                            : generatedPassword,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: generatedPassword.isEmpty
                              ? _textSecondary
                              : _textPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: _primary),
                      onPressed: generatedPassword.isEmpty
                          ? null
                          : () async {
                              await Clipboard.setData(
                                ClipboardData(text: generatedPassword),
                              );

                              setState(() {
                                passwordCtrl.text = generatedPassword;
                                passwordStrengthKey = "strong";
                              });
                            },
                    ),
                  ],
                ),
                if (generatedPassword.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      AppLocalizations.of(context)!.strong,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
				
        _FieldCard(
					label: AppLocalizations.of(context)!.note,
					child: TextField(
						controller: noteCtrl,
						minLines: entryType == "note" ? 6 : 2,
						maxLines: entryType == "note" ? null : 2,
						style: const TextStyle(color: _textPrimary),
						decoration: InputDecoration(
							hintText: AppLocalizations.of(context)!.optionalNote,
							hintStyle: const TextStyle(color: _textSecondary),
							border: InputBorder.none,
						),
					),
				),
				if (entryType == "pattern")
				_FieldCard(
					label: "Pattern",
					child: Column(
						children: [
							_PatternInput(
								value: patternValue,
								onChanged: (val) {
									setState(() {
										patternValue = val;
									});
								},
								onClear: () {
									setState(() {
										patternValue = "";
									});
								},
							),
							const SizedBox(height: 8),
							Text(
								patternValue == null || patternValue!.isEmpty
										? AppLocalizations.of(context)!.drawNewPattern
										: patternValue!,
								style: TextStyle(
									color: _textSecondary,
									fontSize: 12,
								),
							),
							const SizedBox(height: 12),
							Align(
								alignment: Alignment.centerRight,
								child: SizedBox(
									height: 42,
									child: OutlinedButton.icon(
										onPressed: patternValue == null || patternValue!.isEmpty
												? null
												: () {
														setState(() {
															patternValue = "";
														});
													},
										icon: const Icon(Icons.close, size: 18),
										label: Text(AppLocalizations.of(context)!.delete),
										style: OutlinedButton.styleFrom(
											side: BorderSide(color: Colors.white.withOpacity(0.6)),
											foregroundColor: _primary,
											shape: RoundedRectangleBorder(
												borderRadius: BorderRadius.circular(16),
											),
										),
									),
								),
							),
							
						],
					),
				),
if (entryType != "pattern")
  Row(
    children: [
      Expanded(
        child: SizedBox(
          height: 48,
          child: OutlinedButton.icon(
            onPressed: () async {
              LynraApp.of(context).setSuspendAutoLock(true);
              try {
                final result = await FilePicker.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
                );
                if (result == null) return;

                final pickedFile = result.files.first;
                Uint8List? fileBytes = pickedFile.bytes;

                if (fileBytes == null && pickedFile.path != null) {
                  fileBytes = await File(pickedFile.path!).readAsBytes();
                }
                if (fileBytes == null) return;

                final service = AttachmentService();
                final type = service.detectAttachmentType(pickedFile.extension);
                if (type == null) return;

                if (!service.isValidAttachmentSize(fileBytes.length)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.attachmentTooLarge),
                    ),
                  );
                  return;
                }

                setState(() {
                  _attachmentBytes = fileBytes;
                  _attachmentType = type;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.attachmentReady),
                  ),
                );
              } finally {
                LynraApp.of(context).setSuspendAutoLock(false);
              }
            },
            icon: const Icon(Icons.attach_file),
            label: Text(AppLocalizations.of(context)!.addAttachment),
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

      SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          onPressed: save,
          icon: const Icon(Icons.check),
          label: Text(AppLocalizations.of(context)!.save),
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    ],
  )
else
  Row(
    children: [
      const Spacer(),
      SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          onPressed: save,
          icon: const Icon(Icons.check),
          label: Text(AppLocalizations.of(context)!.save),
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    ],
  ),				
					
					
					
					
				],
			),
  );
}
String _strengthText(BuildContext context) {
  final l = AppLocalizations.of(context)!;

  switch (passwordStrengthKey) {
    case "weak":
      return l.weak;
    case "medium":
      return l.medium;
    case "strong":
      return l.strong;
    default:
      return "";
  }
}
 
}

class _FieldCard extends StatelessWidget {
  final String label;
  final Widget child;

  const _FieldCard({
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _TypeButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TypeButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              selected ? const Color(0xFF22D3EE) : const Color(0xFF0F172A),
          foregroundColor: selected ? Colors.black : const Color(0xFFE2E8F0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: selected
                  ? const Color(0xFF22D3EE)
                  : Colors.white.withOpacity(0.05),
            ),
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
class _PatternInput extends StatefulWidget {
  final String? value;
  final ValueChanged<String> onChanged;
	final VoidCallback onClear;
	
  const _PatternInput({
    required this.value,
    required this.onChanged,
		required this.onClear,
  });

  @override
  State<_PatternInput> createState() => _PatternInputState();
}

class _PatternInputState extends State<_PatternInput> {
  final List<int> _selected = [];
  final List<Offset> _centers = [];
  Offset? _currentDragPoint;

  static const double _dotSize = 14;
  static const Color _primary = Color(0xFF22D3EE);
  static const Color _textSecondary = Color(0xFF94A3B8);

  @override
  void initState() {
    super.initState();
    _loadInitialValue();
  }
@override
void didUpdateWidget(covariant _PatternInput oldWidget) {
  super.didUpdateWidget(oldWidget);

  if ((widget.value == null || widget.value!.isEmpty) &&
      oldWidget.value != widget.value) {
    setState(() {
      _selected.clear();
      _currentDragPoint = null;
    });
  }
}
  void _loadInitialValue() {
    final value = widget.value;
    if (value == null || value.trim().isEmpty) return;

    final parts = value
        .split('-')
        .map((e) => int.tryParse(e.trim()))
        .whereType<int>()
        .where((e) => e >= 1 && e <= 9)
        .toList();

    _selected
      ..clear()
      ..addAll(parts);
  }

  void _startDrag(Offset localPosition) {
    setState(() {
      _selected.clear();
      _currentDragPoint = localPosition;
      _selectHitDot(localPosition);
      _emit();
    });
  }

  void _updateDrag(Offset localPosition) {
    setState(() {
      _currentDragPoint = localPosition;
      _selectHitDot(localPosition);
      _emit();
    });
  }

  void _endDrag() {
    setState(() {
      _currentDragPoint = null;
      _emit();
    });
  }

  void _selectHitDot(Offset position) {
    for (int i = 0; i < _centers.length; i++) {
      final center = _centers[i];
      final distance = (position - center).distance;

      if (distance <= 32) {
        final number = i + 1;
        if (!_selected.contains(number)) {
          _selected.add(number);
        }
      }
    }
  }

  void _emit() {
    widget.onChanged(_selected.join('-'));
  }
	
	void _clear() {
		setState(() {
			_selected.clear();
			_currentDragPoint = null;
			widget.onChanged("");
			widget.onClear();
		});
	}	

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          final gridSize = min(size.width, size.height) * 0.76;
          final left = (size.width - gridSize) / 2;
          final top = (size.height - gridSize) / 2;

          _centers
            ..clear()
            ..addAll(List.generate(9, (index) {
              final row = index ~/ 3;
              final col = index % 3;

              return Offset(
                left + (gridSize / 2) * col,
                top + (gridSize / 2) * row,
              );
            }));

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanStart: (details) => _startDrag(details.localPosition),
            onPanUpdate: (details) => _updateDrag(details.localPosition),
            onPanEnd: (_) => _endDrag(),
            onVerticalDragStart: (details) => _startDrag(details.localPosition),
						onVerticalDragUpdate: (details) => _updateDrag(details.localPosition),
						onVerticalDragEnd: (_) => _endDrag(),
						child: CustomPaint(
              painter: _PatternPainter(
                selected: _selected,
                centers: _centers,
                currentDragPoint: _currentDragPoint,
              ),
              child: Stack(
                children: List.generate(9, (index) {
                  final number = index + 1;
                  final center = _centers[index];
                  final selected = _selected.contains(number);

                  return Positioned(
                    left: center.dx - 22,
                    top: center.dy - 22,
                    width: 44,
                    height: 44,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 120),
                        width: selected ? 20 : _dotSize,
                        height: selected ? 20 : _dotSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected
                              ? _primary
                              : _textSecondary.withOpacity(0.45),
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                    color: _primary.withOpacity(0.35),
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
            ),
          );
        },
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  final List<int> selected;
  final List<Offset> centers;
  final Offset? currentDragPoint;

  const _PatternPainter({
    required this.selected,
    required this.centers,
    required this.currentDragPoint,
  });

  static const Color _primary = Color(0xFF22D3EE);

  @override
  void paint(Canvas canvas, Size size) {
    if (selected.isEmpty || centers.length != 9) return;

    final paint = Paint()
      ..color = _primary.withOpacity(0.75)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < selected.length - 1; i++) {
      final from = centers[selected[i] - 1];
      final to = centers[selected[i + 1] - 1];
      canvas.drawLine(from, to, paint);
    }

    if (currentDragPoint != null && selected.isNotEmpty) {
      final last = centers[selected.last - 1];
      canvas.drawLine(last, currentDragPoint!, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PatternPainter oldDelegate) {
    return oldDelegate.selected != selected ||
        oldDelegate.centers != centers ||
        oldDelegate.currentDragPoint != currentDragPoint;
  }
}