import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'features/auth/data/auth_storage.dart';
import 'features/auth/ui/pattern_setup_screen.dart';
import 'features/auth/ui/pattern_unlock_screen.dart';
import 'features/vault/ui/vault_list_screen.dart';
import 'features/settings/ui/pin_unlock_screen.dart';
import 'features/settings/ui/security_screen.dart';
import 'splash_screen.dart';
import 'features/onboarding/ui/onboarding_screen.dart';
import 'core/security/biometric_helper.dart';
import 'core/db/database_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  print(DateTime.now());
  print("Time_Check1");
  runApp(const LynraApp());
}

class LynraApp extends StatefulWidget  {
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

Future<void>  setLocale(Locale locale) async  {
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
		Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
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
  bool _suspendAutoLock = false;  
  final storage = const FlutterSecureStorage();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
	//??_secureScreen();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _start();
    });	
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isAuthenticating) return;
	if (//state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
	  if (LynraApp.of(context).suspendAutoLock) return;
      if (_unlocked) {
		  DatabaseHelper.instance.close(); // 🔒 DB kapat

		  setState(() {
			_unlocked = false;
		  });
		}
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
print(DateTime.now());
print("Time_Check2");
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
	setState(() {
	  _loading = false;
	  _unlocked = false;
	  _savedPattern = null;
	});
	return;
  }

  await AuthStorage.savePattern(createdPattern);
  _savedPattern = createdPattern;

  await _unlockExistingPattern();

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

  _unlockScreenOpen = true;

  // 1. Tipi bool'dan String'e çektik
  final String? resultPattern = await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (_) => PatternUnlockScreen(savedPattern: _savedPattern!),
    ),
  );

  _unlockScreenOpen = false;

  if (!mounted) return;

  // 2. Eğer desen null değilse (yani başarıyla girildiyse)
  if (resultPattern != null) {
    // 3. KRİTİK: Buradaki resultPattern senin artık asıl 'vaultKey'in!
    // Eğer bu fonksiyon bir State içindeyse, vaultKey'i burada güncelliyoruz.
    setState(() {
      vaultKey = resultPattern; 
    });

    final ok = await _checkSecondaryLock();
    setState(() {
      _unlocked = ok;
	  print(DateTime.now());
  print("Time_Check3");
    });
    
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

    if (_unlocked) {
      if (vaultKey != null) {
  return VaultListScreen(vaultKey: vaultKey!); // vaultKey = "0-3-6-7"
}
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