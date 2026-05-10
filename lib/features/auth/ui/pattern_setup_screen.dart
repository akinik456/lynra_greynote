import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/data/auth_storage.dart';
import '../../../core/security/crypto_helper.dart';
import '../../../core/theme/app_colors.dart';

class PatternSetupScreen extends StatefulWidget {
  const PatternSetupScreen({super.key});

  @override
  State<PatternSetupScreen> createState() => _PatternSetupScreenState();
}

class _PatternSetupScreenState extends State<PatternSetupScreen> {
  List<int>? firstPattern;
  String messageKey = 'drawNewPattern';
  
  static const Color _primary = AppColors.success;

void onPatternComplete(List<int> pattern) async { // async ekledik
  if (pattern.length < 5) {
    setState(() { messageKey = 'min5Dots'; });
    return;
  }

  if (firstPattern == null) {
    setState(() {
      firstPattern = List<int>.from(pattern);
      messageKey = 'confirmPattern';
    });
    return;
  }

  final same = firstPattern!.length == pattern.length &&
      firstPattern!.asMap().entries.every((e) => e.value == pattern[e.key]);

  if (!same) {
    setState(() {
      firstPattern = null;
      messageKey = 'patternMismatch';
    });
    return;
  }

  // --- KALE İNŞASI BURADA BAŞLIYOR ---
  final patternString = pattern.join('-');
  
  // 1. Onboarding'de üretilen ham Master Key'i al
  final rawMK = await AuthStorage.getRawMasterKey();
  
  if (rawMK != null) {
    // 2. Master Key'i kullanıcının yeni deseniyle mühürle
    final wrappedMK = await CryptoHelper.wrapMasterKey(
      mkBase64: rawMK,
      password: patternString, // '0-1-2-5' gibi
    );
    
    // 3. Paketli anahtarı sakla. Artık unwrap yapılabilecek.
    await AuthStorage.saveWrappedMasterKey(wrappedMK);
	
	await AuthStorage.deleteRawMasterKey();
  }
  // --- KALE İNŞASI BİTTİ ---

  if (mounted) {
    Navigator.pop(context, patternString);
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
      backgroundColor:  AppColors.transparent,
      extendBodyBehindAppBar: true,
	  appBar: AppBar(
        backgroundColor: AppColors.transparent,
		surfaceTintColor: AppColors.transparent,
		
        elevation: 0,
        centerTitle: false,
        title: Text(
				AppLocalizations.of(context)!.createVaultKey,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: Stack(
        children: [
          const _PatternBackground(),
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
                      color: Colors.white.withOpacity(AppOpacity.subtle),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withOpacity(AppOpacity.subtle),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _primary.withOpacity(AppOpacity.subtle),
                            border: Border.all(
                              color: _primary.withOpacity(AppOpacity.overlay),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _primary.withOpacity(AppOpacity.subtleStrong),
                                blurRadius: 24,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.shield_outlined,
                            color: _primary,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
													AppLocalizations.of(context)!.lynraSecurity,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
												_t(context, messageKey),
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
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
                      color: Colors.white.withOpacity(AppOpacity.subtle),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: _primary.withOpacity(AppOpacity.subtleStrong),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(AppOpacity.overlay),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 320,
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
  const _PatternBackground();

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
                AppColors.surface,
                AppColors.background,
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
              color: AppColors.success.withOpacity(AppOpacity.subtle),
              boxShadow: [
                BoxShadow(
                  color: AppColors.success.withOpacity(AppOpacity.subtleStrong),
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
              color: AppColors.success.withOpacity(AppOpacity.subtle),
              boxShadow: [
                BoxShadow(
                  color: AppColors.success.withOpacity(AppOpacity.subtle),
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
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
class SimplePatternLock extends StatefulWidget {
  final Function(List<int>) onComplete;

  const SimplePatternLock({super.key, required this.onComplete});

  @override
  State<SimplePatternLock> createState() => _SimplePatternLockState();
}

class _SimplePatternLockState extends State<SimplePatternLock> {
  final List<int> selected = [];

  Offset? getPosition(int index, Size size) {
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
      final pos = getPosition(i, size)!;
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
            widget.onComplete(List.from(selected));
            selected.clear();
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

  static const primary = AppColors.success;
  static const idle = AppColors.textSecondary;

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
    final dotPaint = Paint()..style = PaintingStyle.fill;

    final glowPaint = Paint()
  ..color = primary.withOpacity(AppOpacity.overlay)
  ..strokeWidth = 8
  ..strokeCap = StrokeCap.round
  ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final linePaint = Paint()
  ..color = primary
  ..strokeWidth = 3
  ..strokeCap = StrokeCap.round;
    // çizgiler
    for (int i = 0; i < selected.length - 1; i++) {
      final p1 = getPosition(selected[i], size);
      final p2 = getPosition(selected[i + 1], size);
      canvas.drawLine(p1, p2, glowPaint);
	  canvas.drawLine(p1, p2, linePaint);
    }

    // noktalar (DOT ●)
    for (int i = 0; i < 9; i++) {
      final pos = getPosition(i, size);

      dotPaint.color = selected.contains(i) ? primary : idle;

      canvas.drawCircle(pos, 6, dotPaint); // <-- GERÇEK DOT
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

String _t(BuildContext context, String key) {
  final l = AppLocalizations.of(context)!;

  switch (key) {
    case 'min5Dots':
      return l.min5Dots;
    case 'confirmPattern':
      return l.confirmPattern;
    case 'patternMismatch':
      return l.patternMismatch;
    default:
      return l.drawNewPattern;
  }
}