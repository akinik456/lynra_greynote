import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../l10n/app_localizations.dart';

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
              Center(
				child: Text(
				AppLocalizations.of(context)!.privateByDesign,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
			  AppLocalizations.of(context)!.onboardingDescription,
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
                  child: Text(AppLocalizations.of(context)!.continueText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}