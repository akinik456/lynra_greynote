import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Center(
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    size: 46,
                    color: Color(0xFF22D3EE),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Center(
                child: Text(
                  "Private by Design",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                "Your data stays on your device.\n\n"
                "LynraGreyNote does not use servers, does not track you, and does not collect any information.\n\n"
                "Everything you save is encrypted and stored locally.\n"
                "You are the only one who can access it.\n\n"
                "Use Secondary PIN or Biometrics for quick and secure access.\n"
                "Enable Vault Word to add an extra layer of privacy and hide your content when needed.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.white.withOpacity(0.82),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await storage.write(
                      key: "onboarding_seen",
                      value: "true",
                    );

                    if (context.mounted) {
                      Navigator.pop(context, true);
                    }
                  },
                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}