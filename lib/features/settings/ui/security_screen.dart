import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'pin_setup_screen.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/security/biometric_helper.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/data/auth_storage.dart';

class SecurityScreen extends StatefulWidget {
  
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  String lockType = "Pattern";
  String secondaryLock = "none";

  final storage = const FlutterSecureStorage();
  final auth = LocalAuthentication();

  static const Color _primary = AppColors.accent;

  @override
  void initState() {
    super.initState();
    loadSecondaryLock();
  }

  Future<void> saveSecondaryLock(String value) async {
    await storage.write(key: "secondary_lock", value: value);
  }
  Future<void> loadSecondaryLock() async {
    final value = await AuthStorage.safeRead( "secondary_lock");
    if (value != null) {
      setState(() {
        secondaryLock = value;
      });
    }
  }
String getSecondaryLockText() {
  switch (secondaryLock) {
    case "pin":
      return AppLocalizations.of(context)!.pin;
    case "biometric_pin":
      return AppLocalizations.of(context)!.biometricWithBackupPin;
    default:
      return AppLocalizations.of(context)!.none;
  }
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
        title: Text(
		AppLocalizations.of(context)!.security,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Item(
            title: AppLocalizations.of(context)!.secondaryLock,
            subtitle: getSecondaryLockText(),
            onTap: openLockSelector,
          ),
		  
        ],
      ),
    );
  }

void openLockSelector() {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.secondaryLock,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 20),

              _DialogItem(
                title: AppLocalizations.of(context)!.none,
                selected: secondaryLock == "none",
                onTap: () {
                  setState(() => secondaryLock = "none");
                  saveSecondaryLock(secondaryLock);
                  Navigator.pop(context);
                },
              ),

              _DialogItem(
                title: AppLocalizations.of(context)!.pin,
                selected: secondaryLock == "pin",
                onTap: () async {
                  Navigator.pop(context);

                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PinSetupScreen(mode: "pin"),
                    ),
                  );

                  if (result == true) {
                    setState(() => secondaryLock = "pin");
                    saveSecondaryLock(secondaryLock);
                  }
                },
              ),

              _DialogItem(
                title: AppLocalizations.of(context)!.biometricWithBackupPin,
                selected: secondaryLock == "biometric_pin",
                onTap: () async {
                  final ok = await testBiometricForSetup(context);
                  if (!ok) return;

                  Navigator.pop(context);

                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PinSetupScreen(mode: "biometric_pin"),
                    ),
                  );

                  if (result == true) {
                    setState(() => secondaryLock = "biometric_pin");
                    saveSecondaryLock(secondaryLock);
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
}

class _Item extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _Item({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  static const Color _primary = AppColors.accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(AppOpacity.subtle),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.textSecondary,
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

class _DialogItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool selected;

  const _DialogItem({
    required this.title,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.accent.withOpacity(AppOpacity.subtleStrong)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: AppColors.textPrimary),
              ),
            ),
            if (selected)
              const Icon(Icons.check, color: AppColors.accent),
          ],
        ),
      ),
    );
  }
}