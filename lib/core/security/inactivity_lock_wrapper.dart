import 'dart:async';

import 'package:flutter/material.dart';

class InactivityLockWrapper extends StatefulWidget {
  final Widget child;
  final Duration timeout;
  final VoidCallback onTimeout;
  final bool enabled;

  const InactivityLockWrapper({
    super.key,
    required this.child,
    required this.onTimeout,
    required this.enabled,
    this.timeout = const Duration(minutes: 1),
  });

  @override
  State<InactivityLockWrapper> createState() => _InactivityLockWrapperState();
}

class _InactivityLockWrapperState extends State<InactivityLockWrapper> {
  Timer? _timer;
  bool _timedOut = false;

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant InactivityLockWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.enabled && widget.enabled) {
      _timedOut = false;
      _startTimer();
    }

    if (oldWidget.enabled && !widget.enabled) {
      _timer?.cancel();
      _timedOut = false;
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(widget.timeout, _handleTimeout);
  }

  void _resetTimer() {
    if (!widget.enabled) return;
    if (_timedOut) return;
    _startTimer();
  }

  void _handleTimeout() {
    if (!mounted || _timedOut || !widget.enabled) return;
    _timedOut = true;
    widget.onTimeout();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _resetTimer(),
      onPointerMove: (_) => _resetTimer(),
      child: widget.child,
    );
  }
}
