import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/data/auth_storage.dart';
import '../../../core/theme/app_colors.dart';


class PinSetupScreen extends StatefulWidget {
  final String mode;

  const PinSetupScreen({super.key, required this.mode});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final pinCtrl = TextEditingController();
  final confirmPinCtrl = TextEditingController();

  bool obscurePin = true;
  final storage = const FlutterSecureStorage();

  static const Color _primary = AppColors.accent;

  Future<bool> hasPin() async {
    final value = await AuthStorage.safeRead("user_pin");
    return value != null;
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
		AppLocalizations.of(context)!.setPin,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
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
            const SizedBox(height: 14),
            _FieldCard(
              label: AppLocalizations.of(context)!.confirmPin,
              child: TextField(
                controller: confirmPinCtrl,
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
                onPressed: () async {
                  final pin = pinCtrl.text.trim();
                  final confirmPin = confirmPinCtrl.text.trim();

                  if (pin.length != 6 || confirmPin.length != 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.pinMustBe6Digits)),
                    );
                    return;
                  }

                  if (pin != confirmPin) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.pinsDoNotMatch)),
                    );
                    return;
                  }
                  await storage.write(key: "user_pin", value: pin);
				  await storage.write(key: "secondary_lock", value: widget.mode);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.pinSaved)),
                  );

                  Navigator.pop(context,true);
                },
                child: Text(AppLocalizations.of(context)!.savePin),
                  //style: TextStyle(fontWeight: FontWeight.w700),
                //),
              ),
            ),
          ],
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
  hasLabel ? 14 : 14, // 👈 label yoksa üst boşluğu küçült
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
					if (label.isNotEmpty) ...[
						Text(
							label,
							style: TextStyle(
								color: Colors.white.withOpacity(AppOpacity.secondary), // ✅ eski hal
								fontSize: 12,
								fontWeight: FontWeight.w600,          // ✅ eski hal
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