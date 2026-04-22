import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../../../l10n/app_localizations.dart';

Future<bool> tryBiometricUnlock() async {
  final auth = LocalAuthentication();

  try {
    final canCheck = await auth.canCheckBiometrics;
    if (!canCheck) return false;

    return await auth.authenticate(
      localizedReason: 'Authenticate to continue',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );
  } catch (e) {
    print("BIO ERROR => $e");
    return false;
  }
}
Future<bool> testBiometricForSetup(BuildContext context) async{
final auth = LocalAuthentication();
  final canCheck = await auth.canCheckBiometrics;
  if (!canCheck) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.biometricNotAvailable),
      ),
    );
    return false;
  }
  final authenticated = await auth.authenticate(
    localizedReason: AppLocalizations.of(context)!.authenticateToContinue,
    options: const AuthenticationOptions(
      biometricOnly: true,
    ),
  );
  if (!authenticated) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.biometricFailed),
      ),
    );
  }
  return authenticated;
}
