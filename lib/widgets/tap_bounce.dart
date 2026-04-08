import 'package:flutter/material.dart';

class TapBounce extends StatefulWidget {
  const TapBounce({
    super.key,
    required this.child,
    this.onTap,
    this.peakScale = 1.22,
    this.duration = const Duration(milliseconds: 400),
  });

  final Widget child;
  final VoidCallback? onTap;
  final double peakScale;
  final Duration duration;

  @override
  State<TapBounce> createState() => _TapBounceState();
}

class _TapBounceState extends State<TapBounce>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: widget.peakScale)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: widget.peakScale, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 70,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails _) {
    _isPressed = true;
    _controller.value = 0;
    _controller.animateTo(0.3, duration: const Duration(milliseconds: 120)).then(
      (_) { if (!_isPressed && mounted) _controller.forward(); },
      onError: (_) {},
    );
  }

  void _handleTapUp(TapUpDetails _) {
    widget.onTap?.call();
    _isPressed = false;
    if (_controller.value >= 0.3) _controller.forward();
  }

  void _handleTapCancel() {
    _isPressed = false;
    if (_controller.value >= 0.3) _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AbsorbPointer(child: widget.child),
      ),
    );
  }
}
