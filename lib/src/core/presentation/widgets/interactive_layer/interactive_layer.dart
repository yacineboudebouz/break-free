import 'package:flutter/material.dart';
part 'interaction_options.dart';

class InteractiveLayer extends StatefulWidget {
  const InteractiveLayer({
    super.key,
    required this.child,
    required this.config,
    this.onTap,
    this.onHover,
    this.enabled = true,
  });

  final Widget child;
  final InteractionConfig config;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onHover;
  final bool enabled;

  @override
  State<InteractiveLayer> createState() => _InteractiveLayerState();
}

class _InteractiveLayerState extends State<InteractiveLayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.config.duration,
    );
    _setupAnimations();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: _getScaleValue(),
    ).animate(CurvedAnimation(parent: _controller, curve: widget.config.curve));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: widget.config.glowRadius ?? 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.config.curve));

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: widget.config.liftOffset ?? Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.config.curve));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.config.curve));
  }

  double _getScaleValue() {
    return switch (widget.config.type) {
      InteractionType.scaleIn => widget.config.intensity,
      InteractionType.scaleOut => widget.config.intensity,
      InteractionType.bounce => 1.1,
      _ => 1.0,
    };
  }

  void _handleHover(bool isHovered) {
    if (!widget.enabled) return;

    setState(() {
      _isHovered = isHovered;
    });
    widget.onHover?.call(isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    widget.onHover?.call(isHovered);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.config.type == InteractionType.none || !widget.enabled) {
      return GestureDetector(onTap: widget.onTap, child: widget.child);
    }
    return GestureDetector(
      onTapUp: (_) => _handleHover(false),
      onTapDown: (_) => _handleHover(true),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: _offsetAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: _buildWithEffect(widget.child),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWithEffect(Widget child) {
    return switch (widget.config.type) {
      InteractionType.glow => _buildGlowEffect(child),
      InteractionType.fade => Opacity(
        opacity: _fadeAnimation.value,
        child: child,
      ),
      _ => child,
    };
  }

  Widget _buildGlowEffect(Widget child) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, _) {
        return Container(
          decoration: _glowAnimation.value > 0
              ? BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color:
                          (widget.config.glowColor ??
                                  Theme.of(context).primaryColor)
                              .withOpacity(
                                0.3 *
                                    (_glowAnimation.value /
                                        (widget.config.glowRadius ?? 1.0)),
                              ),
                      blurRadius: _glowAnimation.value,
                      spreadRadius: _glowAnimation.value * 0.3,
                    ),
                  ],
                )
              : null,
          child: child,
        );
      },
    );
  }
}
