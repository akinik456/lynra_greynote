import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/data/auth_storage.dart';
import '../../../core/theme/app_colors.dart';

class PinUnlockScreen extends StatefulWidget {
  const PinUnlockScreen({super.key});

  @override
  State<PinUnlockScreen> createState() => _PinUnlockScreenState();
}

class _PinUnlockScreenState extends State<PinUnlockScreen> {
  final pinCtrl = TextEditingController();
  final storage = const FlutterSecureStorage();
  bool obscurePin = true;

  static const Color _primary = AppColors.accent;

  Future<void> checkPin() async {
    final savedPin = await AuthStorage.safeRead("user_pin");
    final enteredPin = pinCtrl.text.trim();

    if (savedPin != null && enteredPin == savedPin) {
      Navigator.pop(context, true);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.wrongPin)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          surfaceTintColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          title: Text(
			AppLocalizations.of(context)!.enterPin,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => SystemNavigator.pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FieldCard(
                label: AppLocalizations.of(context)!.enterPin,
                child: TextField(
                  controller: pinCtrl,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  obscureText: obscurePin,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    letterSpacing: 4,
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "••••••",
                    hintStyle: const TextStyle(color: AppColors.textSecondary),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePin
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePin = !obscurePin;
                        });
                      },
                    ),
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
                  onPressed: checkPin,
                  child: Text(
					AppLocalizations.of(context)!.unlock,
                  ),
                ),
              ),
            ],
          ),
        ),
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
    final hasLabel = label.trim().isNotEmpty;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        hasLabel ? 14 : 10,
        12,
        14,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(AppOpacity.subtle),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasLabel) ...[
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(AppOpacity.secondary),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
          ],
          child,
        ],
      ),
    );
  }
}