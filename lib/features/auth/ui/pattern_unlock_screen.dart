import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../l10n/app_localizations.dart';

class PatternUnlockScreen extends StatefulWidget {
  final String savedPattern;

  const PatternUnlockScreen({
    super.key,
    required this.savedPattern,
  });

  @override
  State<PatternUnlockScreen> createState() => _PatternUnlockScreenState();
}

class _PatternUnlockScreenState extends State<PatternUnlockScreen> {
  String messageKey = 'drawVaultKey';

  static const Color _bgBottom = Color(0xFF020617);
  static const Color _primary = Color(0xFF14B8A6);
  static const Color _textPrimary = Color(0xFFE2E8F0);
  static const Color _textSecondary = Color(0xFF94A3B8);

// Mevcut onPatternComplete fonksiyonunu şu şekilde güncelle:
void onPatternComplete(List<int> pattern) {
  // 1. Deseni her zaman tireli formatta birleştiriyoruz (Örn: "0-1-2-5")
  final input = pattern.join('-');

  if (input == widget.savedPattern) {
    // 2. Sadece true değil, deseni (vaultKey) geri gönderiyoruz.
    // Bu sayede Master Key'i çözmek için elimizde doğru formatlı anahtar olacak.
    Navigator.pop(context, input); 
  } else {
    setState(() {
      messageKey = 'wrongPattern';
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
  onWillPop: () async {
    SystemNavigator.pop();
    return false;
  },
  child:   Scaffold(
      backgroundColor:  Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
		surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
		AppLocalizations.of(context)!.unlock,
          style: TextStyle(
            color: _textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: _textPrimary),
      ),
      body: Stack(
        children: [
          _PatternBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _primary.withOpacity(0.08),
                            border: Border.all(
                              color: _primary.withOpacity(0.28),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _primary.withOpacity(0.12),
                                blurRadius: 24,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.lock_outline,
                            color: _primary,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
						AppLocalizations.of(context)!.unlockVault,
                          style: TextStyle(
                            color: _textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 8),
						Text(_t(context, messageKey),
                          style: const TextStyle(
                            color: _textSecondary,
                            fontSize: 15,
                            height: 1.45,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: _primary.withOpacity(0.14),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 300,
                      child: SimplePatternLock(
                        onComplete: onPatternComplete,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
	  ),
    );
  }
}

class _PatternBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0F172A),
                Color(0xFF020617),
              ],
            ),
          ),
        ),
        Positioned(
          top: 120,
          left: -80,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF14B8A6).withOpacity(0.08),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF14B8A6).withOpacity(0.10),
                  blurRadius: 120,
                  spreadRadius: 30,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 140,
          right: -60,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF14B8A6).withOpacity(0.05),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF14B8A6).withOpacity(0.08),
                  blurRadius: 100,
                  spreadRadius: 22,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Opacity(
            opacity: 0.05,
            child: Icon(
              Icons.shield_outlined,
              size: 300,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class SimplePatternLock extends StatefulWidget {
  final Function(List<int>) onComplete;

  const SimplePatternLock({
    super.key,
    required this.onComplete,
  });

  @override
  State<SimplePatternLock> createState() => _SimplePatternLockState();
}

class _SimplePatternLockState extends State<SimplePatternLock> {
  final List<int> selected = [];

  Offset getPosition(int index, Size size) {
    final row = index ~/ 3;
    final col = index % 3;

    final spacingX = size.width / 3;
    final spacingY = size.height / 3;

    return Offset(
      spacingX * col + spacingX / 2,
      spacingY * row + spacingY / 2,
    );
  }

  int? getHitIndex(Offset point, Size size) {
    for (int i = 0; i < 9; i++) {
      final pos = getPosition(i, size);
      if ((point - pos).distance < 40) {
        return i;
      }
    }
    return null;
  }
int? getIntermediate(int a, int b) {
  final rowA = a ~/ 3;
  final colA = a % 3;
  final rowB = b ~/ 3;
  final colB = b % 3;

  final rowDiff = rowB - rowA;
  final colDiff = colB - colA;

  if (rowDiff.abs() == 2 && colDiff.abs() == 2) {
    return 4; // çapraz orta
  }

  if (rowA == rowB && colDiff.abs() == 2) {
    return rowA * 3 + 1; // yatay orta
  }

  if (colA == colB && rowDiff.abs() == 2) {
    return 1 * 3 + colA; // dikey orta
  }

  return null;
}
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return GestureDetector(
          onPanStart: (details) {
            selected.clear();
            final index = getHitIndex(details.localPosition, size);
            if (index != null) {
              setState(() {
                selected.add(index);
              });
            }
          },
          onPanUpdate: (details) {
            final index = getHitIndex(details.localPosition, size);
            if (index != null && !selected.contains(index)) {
  if (selected.isNotEmpty) {
    final last = selected.last;
    final mid = getIntermediate(last, index);

    if (mid != null && !selected.contains(mid)) {
      selected.add(mid);
    }
  }

  setState(() {
    selected.add(index);
  });
}
          },
          onPanEnd: (_) {
            widget.onComplete(List<int>.from(selected));
            setState(() {
              selected.clear();
            });
          },
          child: CustomPaint(
            size: size,
            painter: _PatternPainter(selected: selected),
          ),
        );
      },
    );
  }
}

class _PatternPainter extends CustomPainter {
  final List<int> selected;

  _PatternPainter({required this.selected});

  static const Color primary = Color(0xFF14B8A6);
  static const Color idle = Color(0xFF94A3B8);

  Offset getPosition(int index, Size size) {
    final row = index ~/ 3;
    final col = index % 3;

    final spacingX = size.width / 3;
    final spacingY = size.height / 3;

    return Offset(
      spacingX * col + spacingX / 2,
      spacingY * row + spacingY / 2,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final glowPaint = Paint()
      ..color = primary.withOpacity(0.25)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final linePaint = Paint()
      ..color = primary
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < selected.length - 1; i++) {
      final p1 = getPosition(selected[i], size);
      final p2 = getPosition(selected[i + 1], size);
      canvas.drawLine(p1, p2, glowPaint);
      canvas.drawLine(p1, p2, linePaint);
    }

    for (int i = 0; i < 9; i++) {
      final pos = getPosition(i, size);

      dotPaint.color = selected.contains(i) ? primary : idle;

      if (selected.contains(i)) {
        canvas.drawCircle(pos, 10, glowPaint);
      }

      canvas.drawCircle(pos, 6, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _PatternPainter oldDelegate) {
    return oldDelegate.selected != selected;
  }
}

String _t(BuildContext context, String key) {
  final l = AppLocalizations.of(context)!;

  switch (key) {
    case 'wrongPattern':
      return l.wrongPattern;
    default:
      return l.drawVaultKey;
  }
}