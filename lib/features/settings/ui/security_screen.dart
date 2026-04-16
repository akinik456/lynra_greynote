import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'pin_setup_screen.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  String lockType = "Pattern";
  String secondaryLock = "None";

  final storage = const FlutterSecureStorage();
  final auth = LocalAuthentication();

  static const Color _bgColor = Color(0xFF020617);
  static const Color _cardColor = Color(0xFF0F172A);
  static const Color _primary = Color(0xFF22D3EE);
  static const Color _textPrimary = Color(0xFFE2E8F0);
  static const Color _textSecondary = Color(0xFF94A3B8);

  @override
  void initState() {
    super.initState();
    loadSecondaryLock();
  }

  Future<void> saveSecondaryLock(String value) async {
    await storage.write(key: "secondary_lock", value: value);
  }

  Future<void> loadSecondaryLock() async {
    final value = await storage.read(key: "secondary_lock");
    if (value != null) {
      setState(() {
        secondaryLock = value;
      });
    }
  }

  Future<void> testBiometric() async {
    final canCheck = await auth.canCheckBiometrics;

    if (!canCheck) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Biometric not available")),
      );
      return;
    }

    final authenticated = await auth.authenticate(
      localizedReason: "Authenticate to continue",
      options: const AuthenticationOptions(
        biometricOnly: true,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          authenticated ? "Biometric success" : "Biometric failed",
        ),
      ),
    );
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
          "Security",
          style: TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Item(
            title: "Secondary Lock",
            subtitle: secondaryLock,
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
          backgroundColor: _cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Secondary Lock",
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                _DialogItem(
                  title: "None",
                  onTap: () {
                    setState(() => secondaryLock = "None");
                    saveSecondaryLock(secondaryLock);
                    Navigator.pop(context);
                  },
                ),
                _DialogItem(
                  title: "PIN",
                  onTap: () async {
                    final existing = await storage.read(key: "secondary_lock");

                    if (existing != "PIN") {
                      setState(() => secondaryLock = "PIN");
                      saveSecondaryLock(secondaryLock);
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PinSetupScreen(),
                        ),
                      );
                    }
                  },
                ),
                _DialogItem(
                  title: "Biometric",
                  onTap: () async {
                    await testBiometric();
                    setState(() => secondaryLock = "Biometric");
                    saveSecondaryLock(secondaryLock);
                    Navigator.pop(context);
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

  static const Color _cardColor = Color(0xFF0F172A);
  static const Color _primary = Color(0xFF22D3EE);
  static const Color _textPrimary = Color(0xFFE2E8F0);
  static const Color _textSecondary = Color(0xFF94A3B8);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: _textSecondary,
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

  const _DialogItem({
    required this.title,
    required this.onTap,
  });

  static const Color _textPrimary = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: _textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
    );
  }
}