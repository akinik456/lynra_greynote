import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String message = 'Draw your vault key';

  static const Color _bgBottom = Color(0xFF020617);
  static const Color _primary = Color(0xFF14B8A6);
  static const Color _textPrimary = Color(0xFFE2E8F0);
  static const Color _textSecondary = Color(0xFF94A3B8);

  void onPatternComplete(List<int> pattern) {
    final input = pattern.join('-');

    if (input == widget.savedPattern) {
      Navigator.pop(context, true);
    } else {
      setState(() {
        message = 'Wrong pattern. Try again';
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
      backgroundColor: _bgBottom,
      appBar: AppBar(
        backgroundColor: const Color(0xFF020617),
surfaceTintColor: const Color(0xFF020617),
        elevation: 0,
        title: const Text(
          'Unlock',
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
                        const Text(
                          'Unlock Vault',
                          style: TextStyle(
                            color: _textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message,
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
      if ((point - pos).distance < 30) {
        return i;
      }
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