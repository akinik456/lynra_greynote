import 'dart:async';
import 'package:flutter/material.dart';
import '../../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      
      // DOĞRU YOL: Direkt VaultList'e değil, AppGate'e gidiyoruz.
      // Çünkü vaultKey henüz üretilmedi, onu AppGate içindeki kilit ekranı üretecek.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>  AppGate(), 
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: Center(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: 0.8, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: value,
                child: child,
              ),
            );
          },
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF22D3EE).withOpacity(0.25),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/icon/icon_dark.png', // 👈 icon dosyan
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}