import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import '../../../l10n/app_localizations.dart';

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
    }
	ibanCtrl.text = widget.initialData?["iban"] ?? "";
	showBankDetails = ibanCtrl.text.trim().isNotEmpty;
	entryType = widget.initialData?["type"] ?? "standard";
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
    Navigator.pop(context, {
      "title": titleCtrl.text.trim(),
      "username": usernameCtrl.text.trim(),
      "password": passwordCtrl.text,
      "note": noteCtrl.text.trim(),
      "iban": showBankDetails ? ibanCtrl.text.trim() : "",
      "type": entryType,
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
          ],
        ),
        const SizedBox(height: 8),

        _FieldCard(
          label: AppLocalizations.of(context)!.title,
          child: SizedBox(
            height: 14,
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
              height: 14,
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
            label: AppLocalizations.of(context)!.generatePassword,
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
                const SizedBox(height: 12),
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
      ],
    ),
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: _primary,
      foregroundColor: Colors.black,
      onPressed: save,
      label: Text(AppLocalizations.of(context)!.save),
      icon: const Icon(Icons.check),
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