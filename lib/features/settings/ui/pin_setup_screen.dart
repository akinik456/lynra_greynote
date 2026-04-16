import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final pinCtrl = TextEditingController();
  final confirmPinCtrl = TextEditingController();

  bool obscurePin = true;
  final storage = const FlutterSecureStorage();

  static const Color _bgColor = Color(0xFF020617);
  static const Color _cardColor = Color(0xFF0F172A);
  static const Color _primary = Color(0xFF22D3EE);
  static const Color _textPrimary = Color(0xFFE2E8F0);
  static const Color _textSecondary = Color(0xFF94A3B8);

  Future<bool> hasPin() async {
    final value = await storage.read(key: "user_pin");
    return value != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _bgColor,
        surfaceTintColor: _bgColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Set PIN",
          style: TextStyle(
            color: _textPrimary,
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
              label: "Enter PIN",
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
            const SizedBox(height: 14),
            _FieldCard(
              label: "Confirm PIN",
              child: TextField(
                controller: confirmPinCtrl,
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
                onPressed: () async {
                  final pin = pinCtrl.text.trim();
                  final confirmPin = confirmPinCtrl.text.trim();

                  if (pin.length != 6 || confirmPin.length != 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("PIN must be 6 digits")),
                    );
                    return;
                  }

                  if (pin != confirmPin) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("PINs do not match")),
                    );
                    return;
                  }

                  await storage.write(key: "user_pin", value: pin);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("PIN saved")),
                  );

                  Navigator.pop(context);
                },
                child: const Text(
                  "Save PIN",
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