import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/data/auth_storage.dart';
import '../../../core/theme/app_colors.dart';

class VaultWordScreen extends StatefulWidget {
  const VaultWordScreen({super.key});

  @override
  State<VaultWordScreen> createState() => _VaultWordScreenState();
}

class _VaultWordScreenState extends State<VaultWordScreen> {
  bool enabled = false;
  final storage = const FlutterSecureStorage();
  final wordCtrl = TextEditingController();

  static const Color _primary = AppColors.accent;

  @override
  void initState() {
    super.initState();
    loadVaultWord();
  }

  Future<void> loadVaultWord() async {
    final enabledValue = await AuthStorage.safeRead("vault_word_enabled");
    final savedWord = await AuthStorage.safeRead("vault_word");

    setState(() {
      enabled = enabledValue == "true";
      wordCtrl.text = savedWord ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.vaultWord,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(AppOpacity.subtle),
                ),
              ),
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: _primary,
                title: Text(AppLocalizations.of(context)!.enableVaultWord,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(AppLocalizations.of(context)!.hideSensitiveContent,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
                value: enabled,
                onChanged: (val) {
                  setState(() {
                    enabled = val;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(AppOpacity.subtle),
                ),
              ),
              child: TextField(
                controller: wordCtrl,
                style: TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.vaultWord,
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                  hintText: AppLocalizations.of(context)!.enterVaultWord,
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: AppColors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () async {
                  await storage.write(
                    key: "vault_word_enabled",
                    value: enabled.toString(),
                  );
                  await storage.write(
                    key: "vault_word",
                    value: wordCtrl.text,
                  );

                  Navigator.pop(context, true);
                },
                child: Text(AppLocalizations.of(context)!.save,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}