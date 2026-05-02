import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';

import 'l10n/app_localizations.dart';
import 'core/db/database_helper.dart';
import 'core/security/biometric_helper.dart';
import 'core/security/inactivity_lock_wrapper.dart';
import 'features/auth/data/auth_storage.dart';
import 'features/auth/ui/pattern_setup_screen.dart';
import 'features/auth/ui/pattern_unlock_screen.dart';
import 'features/vault/ui/vault_list_screen.dart';
import 'features/settings/ui/pin_unlock_screen.dart';
import 'features/onboarding/ui/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const LynraApp());
}

class AppLockController {
  static final ValueNotifier<bool> enabled = ValueNotifier<bool>(false);
  static Future<void> Function()? lock;
}

class LynraApp extends StatefulWidget {
  const LynraApp({super.key});

  static _LynraAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_LynraAppState>()!;
  }

  @override
  State<LynraApp> createState() => _LynraAppState();
}

class _LynraAppState extends State<LynraApp> {
  Locale? _locale;
  final storage = const FlutterSecureStorage();
  bool _suspendAutoLock = false;

  void setSuspendAutoLock(bool value) {
    setState(() {
      _suspendAutoLock = value;
    });
  }

  bool get suspendAutoLock => _suspendAutoLock;

  @override
  void initState() {
    super.initState();
    loadLocale();
  }

  Future<void> loadLocale() async {
    final code = await storage.read(key: "app_locale");
    if (code != null) {
      setState(() {
        _locale = Locale(code);
      });
    }
  }

  Future<void> setLocale(Locale locale) async {
    await storage.write(key: "app_locale", value: locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final lang = Localizations.localeOf(context).languageCode;

        double textScale = 1.0;

        if (lang == 'hi'|| lang == 'th') {
          textScale = 1.16;
        } else if (lang == 'ar') {
          textScale = 1.14;
        } else if (lang == 'ja' || lang == 'ko' || lang == 'zh' ) {
          textScale = 1.10;
        }

        final scaledChild = MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
          ),
          child: child!,
        );

        return ValueListenableBuilder<bool>(
          valueListenable: AppLockController.enabled,
          builder: (context, enabled, _) {
            return InactivityLockWrapper(
              enabled: enabled && !_suspendAutoLock,
              onTimeout: () {
                AppLockController.lock?.call();
              },
              child: scaledChild,
            );
          },
        );
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('es'),
        Locale('de'),
        Locale('fr'),
        Locale('it'),
        Locale('hi'),
        Locale('ko'),
        Locale('ja'),
        Locale('zh'),
        Locale('ar'),
        Locale('ru'),
        Locale('id'),
        Locale('vi'),
        Locale('th'),
        Locale('nl'),
        Locale('pl'),
        Locale('sv'),
        Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
      ],
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        cardColor: const Color(0xFF1E293B),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF22D3EE),
        ),
      ),
      home: const AppGate(),
    );
  }
}

class AppGate extends StatefulWidget {
  const AppGate({super.key});

  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> with WidgetsBindingObserver {
  bool _loading = true;
  bool _isAuthenticating = false;
  bool _unlocked = false;
  bool _unlockScreenOpen = false;
  String? _savedPattern;
  String? vaultKey;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AppLockController.lock = _lockFromInactivity;
    _secureScreen();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _start();
    });
  }

  @override
  void dispose() {
    if (AppLockController.lock == _lockFromInactivity) {
      AppLockController.lock = null;
    }
    AppLockController.enabled.value = false;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isAuthenticating) return;

    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) {
      if (LynraApp.of(context).suspendAutoLock) return;
      _lockApp(openUnlock: false);
      return;
    }

    if (state == AppLifecycleState.resumed) {
      if (!_loading && _savedPattern != null && !_unlocked && !_unlockScreenOpen) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _unlockExistingPattern();
        });
      }
    }
  }

  Future<void> _secureScreen() async {
    await FlutterWindowManagerPlus.addFlags(
      FlutterWindowManagerPlus.FLAG_SECURE,
    );
  }

  Future<void> _start() async {
    final storage = const FlutterSecureStorage();
    final seen = await storage.read(key: "onboarding_seen");

    if (seen != "true") {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    }

    final saved = await AuthStorage.getPattern();
    if (!mounted) return;

    if (saved == null || saved.isEmpty) {
      final createdPattern = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (_) => const PatternSetupScreen(),
        ),
      );

      if (createdPattern == null || createdPattern.isEmpty) {
        AppLockController.enabled.value = false;
        setState(() {
          _loading = false;
          _unlocked = false;
          _savedPattern = null;
        });
        return;
      }

      await AuthStorage.savePattern(createdPattern);

setState(() {
  _savedPattern = createdPattern;
  vaultKey = createdPattern;
  _unlocked = true;
  _loading = false;
});
return;
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
      return;
    }

    _savedPattern = saved;
    await _unlockExistingPattern();
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }

  Future<void> _lockFromInactivity() async {
    await _lockApp(openUnlock: true);
  }

  Future<void> _lockApp({required bool openUnlock}) async {
    if (!mounted) return;
    if (!_unlocked) return;

    FocusManager.instance.primaryFocus?.unfocus();
    await DatabaseHelper.instance.close();
    AppLockController.enabled.value = false;

    if (!mounted) return;
    setState(() {
      _unlocked = false;
    });

    if (openUnlock && _savedPattern != null && !_unlockScreenOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _unlockExistingPattern();
      });
    }
  }

  Future<bool> _checkSecondaryLock() async {
    _isAuthenticating = true;
    try {
      final secondaryLock = await storage.read(key: "secondary_lock");

      if (secondaryLock == "pin") {
        final result = await Navigator.push<bool>(
          context,
          MaterialPageRoute(builder: (_) => const PinUnlockScreen()),
        );
        return result == true;
      }

      if (secondaryLock == "biometric_pin") {
        final ok = await tryBiometricUnlock();
        if (ok) return true;

        await Future.delayed(const Duration(milliseconds: 300));
        final result = await Navigator.push<bool>(
          context,
          MaterialPageRoute(builder: (_) => const PinUnlockScreen()),
        );
        return result == true;
      }

      return true;
    } finally {
      _isAuthenticating = false;
    }
  }

  Future<void> _unlockExistingPattern() async {
    if (_savedPattern == null || _savedPattern!.isEmpty) return;
    if (!mounted) return;
    if (_unlockScreenOpen) return;

    AppLockController.enabled.value = false;
    _unlockScreenOpen = true;

    final String? resultPattern = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => PatternUnlockScreen(savedPattern: _savedPattern!),
      ),
    );

    _unlockScreenOpen = false;
    if (!mounted) return;

    if (resultPattern != null) {
      setState(() {
        vaultKey = resultPattern;
      });

      final ok = await _checkSecondaryLock();
      if (!mounted) return;

      setState(() {
        _unlocked = ok;
      });

      AppLockController.enabled.value = ok;
    } else {
      AppLockController.enabled.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_unlocked && vaultKey != null) {
      return VaultListScreen(vaultKey: vaultKey!);
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _unlockExistingPattern();
            });
          },
          child: Text(AppLocalizations.of(context)!.unlock),
        ),
      ),
    );
  }
}
