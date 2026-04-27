import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/data/auth_storage.dart';
import '../../../core/security/crypto_helper.dart';

class OnboardingScreen extends StatelessWidget {
const OnboardingScreen({super.key});

@override
Widget build(BuildContext context) {
const storage = FlutterSecureStorage();

return Scaffold(
  backgroundColor: const Color(0xFF020617),
  body: SafeArea(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            Center(
              child: Image.asset(
                'assets/icon/icon_dark.png',
                width: 90,
              ),
            ),

            const SizedBox(height: 60),

            Center(
              child: Text(
                AppLocalizations.of(context)!.privateByDesign,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              AppLocalizations.of(context)!.onboardingDescription,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.white.withOpacity(0.82),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  side: const BorderSide(
                    color: Color(0xFF22D3EE),
                    width: 1,
                  ),
                ),
                onPressed: () async {
                  await AuthStorage.initializeSecurity();

                  await storage.write(
                    key: "onboarding_seen",
                    value: "true",
                  );

                  if (context.mounted) {
                    Navigator.pop(context, true);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.continueText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);


}
}
