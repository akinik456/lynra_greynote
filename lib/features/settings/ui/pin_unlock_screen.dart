import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../l10n/app_localizations.dart';

class PinUnlockScreen extends StatefulWidget {
  const PinUnlockScreen({super.key});

  @override
  State<PinUnlockScreen> createState() => _PinUnlockScreenState();
}

class _PinUnlockScreenState extends State<PinUnlockScreen> {
  final pinCtrl = TextEditingController();
  final storage = const FlutterSecureStorage();
  bool obscurePin = true;

  static const Color _bgColor = Color(0xFF020617);
  static const Color _cardColor = Color(0xFF0F172A);
  static const Color _primary = Color(0xFF22D3EE);
  static const Color _textPrimary = Color(0xFFE2E8F0);
  static const Color _textSecondary = Color(0xFF94A3B8);

  Future<void> checkPin() async {
    final savedPin = await storage.read(key: "user_pin");
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
        backgroundColor: _bgColor,
        appBar: AppBar(
          backgroundColor: _bgColor,
          surfaceTintColor: _bgColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
			AppLocalizations.of(context)!.enterPin,
            style: TextStyle(
              color: _textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: _textPrimary),
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
                    color: _textPrimary,
                    fontSize: 18,
                    letterSpacing: 4,
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "••••••",
                    hintStyle: const TextStyle(color: _textSecondary),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePin
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: _textSecondary,
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
                    foregroundColor: Colors.black,
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
    return Container(
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