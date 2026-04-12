import 'package:flutter/material.dart';
import 'core/db/database_helper.dart';
import 'features/auth/data/auth_storage.dart';
import 'features/auth/ui/pattern_setup_screen.dart';
import 'features/auth/ui/pattern_unlock_screen.dart';
import 'features/vault/ui/vault_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(const LynraApp());
}

class LynraApp extends StatelessWidget {
  const LynraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  bool _unlocked = false;
  bool _unlockScreenOpen = false;
  String? _savedPattern;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

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
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      if (_unlocked) {
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

  Future<void> _start() async {
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

  Future<void> _unlockExistingPattern() async {
    if (_savedPattern == null || _savedPattern!.isEmpty) return;
    if (!mounted) return;
    if (_unlockScreenOpen) return;

    _unlockScreenOpen = true;

    final unlocked = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PatternUnlockScreen(savedPattern: _savedPattern!),
      ),
    );

    _unlockScreenOpen = false;

    if (!mounted) return;

    setState(() {
      _unlocked = unlocked == true;
    });
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
      return const VaultListScreen();
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _unlockExistingPattern();
            });
          },
          child: const Text('Unlock'),
        ),
      ),
    );
  }
}