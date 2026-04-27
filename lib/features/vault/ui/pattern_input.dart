import 'package:flutter/material.dart';

class PatternInput extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const PatternInput({
    super.key,
    required this.onChanged,
  });

  @override
  State<PatternInput> createState() => _PatternInputState();
}

class _PatternInputState extends State<PatternInput> {
  final List<int> _selected = [];
  final Map<int, Offset> _centers = {};

  static const double _size = 132;
  static const double _dotRadius = 5;
  static const double _hitRadius = 22;

  void _handlePosition(Offset localPosition) {
    for (final entry in _centers.entries) {
      if ((localPosition - entry.value).distance <= _hitRadius &&
          !_selected.contains(entry.key)) {
        setState(() {
          _selected.add(entry.key);
        });

        widget.onChanged(_selected.join("-"));
        break;
      }
    }
  }

  void _clear() {
    setState(() {
      _selected.clear();
    });

    widget.onChanged("");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: (details) => _handlePosition(details.localPosition),
          onPanUpdate: (details) => _handlePosition(details.localPosition),
          child: SizedBox(
            width: _size,
            height: _size,
            child: CustomPaint(
              painter: _PatternPainter(
                selected: _selected,
                centersOut: _centers,
                dotRadius: _dotRadius,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        TextButton(
          onPressed: _clear,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(48, 28),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text("Clear"),
        ),
      ],
    );
  }
}

class _PatternPainter extends CustomPainter {
  final List<int> selected;
  final Map<int, Offset> centersOut;
  final double dotRadius;

  _PatternPainter({
    required this.selected,
    required this.centersOut,
    required this.dotRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    centersOut.clear();

    final linePaint = Paint()
      ..color = const Color(0xFF22D3EE)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final selectedPaint = Paint()
      ..color = const Color(0xFF22D3EE)
      ..style = PaintingStyle.fill;

    final emptyPaint = Paint()
      ..color = Colors.white38
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final gapX = size.width / 4;
    final gapY = size.height / 4;

    for (int i = 1; i <= 9; i++) {
      final row = (i - 1) ~/ 3;
      final col = (i - 1) % 3;

      centersOut[i] = Offset(
        gapX * (col + 1),
        gapY * (row + 1),
      );
    }

    for (int i = 0; i < selected.length - 1; i++) {
      final a = centersOut[selected[i]];
      final b = centersOut[selected[i + 1]];

      if (a != null && b != null) {
        canvas.drawLine(a, b, linePaint);
      }
    }

    for (int i = 1; i <= 9; i++) {
      final center = centersOut[i]!;
      final isSelected = selected.contains(i);

      if (isSelected) {
        canvas.drawCircle(center, dotRadius, selectedPaint);
      } else {
        canvas.drawCircle(center, dotRadius, emptyPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PatternPainter oldDelegate) {
    return oldDelegate.selected != selected;
  }
}