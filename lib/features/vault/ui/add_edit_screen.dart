import 'package:flutter/material.dart';
import 'dart:math';

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
  String passwordStrength = "";

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
      setState(() => passwordStrength = "");
      return;
    }

    int score = 0;

    if (password.length >= 8) score++;
    if (password.length >= 10) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#\$%&*_\-]').hasMatch(password)) score++;

    if (score <= 2) {
      passwordStrength = "Weak";
    } else if (score <= 4) {
      passwordStrength = "Medium";
    } else {
      passwordStrength = "Strong";
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
          isEdit ? "Edit Entry" : "New Entry",
          style: const TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          Row(
            children: [
              Expanded(
                child: _TypeButton(
                  label: "Standard",
                  selected: entryType == "standard",
                  onTap: () {
                    setState(() => entryType = "standard");
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TypeButton(
                  label: "Note",
                  selected: entryType == "note",
                  onTap: () {
                    setState(() => entryType = "note");
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _FieldCard(
            label: "Title",
            child: TextField(
              controller: titleCtrl,
              style: const TextStyle(color: _textPrimary),
              decoration: const InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(color: _textSecondary),
                border: InputBorder.none,
              ),
            ),
          ),
          if (entryType == "standard") ...[
            _FieldCard(
              label: "Username",
              child: TextField(
                controller: usernameCtrl,
                style: const TextStyle(color: _textPrimary),
                decoration: const InputDecoration(
                  hintText: "Username / Email",
                  hintStyle: TextStyle(color: _textSecondary),
                  border: InputBorder.none,
                ),
              ),
            ),
            _FieldCard(
              label: "Bank Details",
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
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
                title: const Text(
                  "Add IBAN",
                  style: TextStyle(color: _textPrimary),
                ),
              ),
            ),
            if (showBankDetails)
              _FieldCard(
                label: "IBAN",
                child: TextField(
                  controller: ibanCtrl,
                  style: const TextStyle(color: _textPrimary),
                  decoration: const InputDecoration(
                    hintText: "TR00 0000 0000 0000 0000 0000 00",
                    hintStyle: TextStyle(color: _textSecondary),
                    border: InputBorder.none,
                  ),
                ),
              ),
            _FieldCard(
              label: "Password",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.refresh, color: _primary),
                        onPressed: () {
                          final generated = generatePassword();
                          setState(() {
                            passwordCtrl.text = generated;
                            updatePasswordStrength(generated);
                          });
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: passwordCtrl,
                          obscureText: hidePassword,
                          onChanged: updatePasswordStrength,
                          style: const TextStyle(color: _textPrimary),
                          decoration: const InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: _textSecondary),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _textSecondary,
                        ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                    ],
                  ),
                  if (passwordStrength.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        passwordStrength,
                        style: TextStyle(
                          color: passwordStrength == "Weak"
                              ? Colors.redAccent
                              : passwordStrength == "Medium"
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
          ],
          _FieldCard(
            label: "Note",
            child: TextField(
              controller: noteCtrl,
              maxLines: entryType == "note" ? 10 : 3,
              style: const TextStyle(color: _textPrimary),
              decoration: const InputDecoration(
                hintText: "Optional note",
                hintStyle: TextStyle(color: _textSecondary),
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
        label: const Text("Save"),
        icon: const Icon(Icons.check),
      ),
    );
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
      height: 46,
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