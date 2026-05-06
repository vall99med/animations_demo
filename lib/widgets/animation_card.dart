import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationCard extends StatefulWidget {
  final String title;
  final String type;
  final Color typeColor;
  final String useCase;

  const AnimationCard({
    super.key,
    required this.title,
    required this.type,
    required this.typeColor,
    required this.useCase,
  });

  @override
  State<AnimationCard> createState() => _AnimationCardState();
}

class _AnimationCardState extends State<AnimationCard>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  bool _toggle = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _startAnimation();
  }

  void _startAnimation() {
    switch (widget.title) {
      case 'Rotate':
        _controller.repeat();
        break;
      case 'Pulse':
        _controller.repeat(reverse: true);
        break;
      case 'Bounce':
        _controller.repeat();
        break;
      default:
        _loopToggle();
        break;
    }
  }

  void _loopToggle() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) setState(() => _toggle = true);
      await Future.delayed(const Duration(milliseconds: 1000));
      if (mounted) setState(() => _toggle = false);
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: widget.typeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  widget.type,
                  style: TextStyle(
                    fontSize: 7,
                    color: widget.typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            widget.useCase,
            style: TextStyle(
              fontSize: 7,
              color: Colors.grey.shade500,
            ),
          ),
          Expanded(
            child: Center(
              child: _buildAnimation(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimation() {
    switch (widget.title) {

      case 'Fade':
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          opacity: _toggle ? 1.0 : 0.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.notifications, color: Colors.white, size: 10),
                SizedBox(width: 3),
                Text('Message',
                    style: TextStyle(color: Colors.white, fontSize: 8)),
              ],
            ),
          ),
        );

      case 'Scale':
        return AnimatedScale(
          duration: const Duration(milliseconds: 300),
          curve: Curves.elasticOut,
          scale: _toggle ? 1.3 : 1.0,
          child: Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: _toggle ? Colors.red : Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite,
              color: _toggle ? Colors.white : Colors.grey,
              size: 16,
            ),
          ),
        );

      case 'Slide':
        return AnimatedSlide(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          offset: _toggle ? Offset.zero : const Offset(-1, 0),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.blue.shade200,
                  child: const Icon(Icons.person,
                      size: 10, color: Colors.white),
                ),
                const SizedBox(width: 3),
                const Text('Bonjour!',
                    style: TextStyle(fontSize: 8)),
              ],
            ),
          ),
        );

      case 'Rotate':
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * math.pi,
              child: child,
            );
          },
          child: Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.sync,
                color: Colors.orange.shade700, size: 18),
          ),
        );

      case 'Bounce':
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final bounce =
                math.sin(_controller.value * 2 * math.pi).abs();
            return Transform.translate(
              offset: Offset(0, -12 * bounce),
              child: child,
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 28, height: 28,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.mail,
                    color: Colors.white, size: 14),
              ),
              Positioned(
                right: -3, top: -3,
                child: Container(
                  width: 12, height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text('3',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 7,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        );

      case 'Pulse':
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 14 + (_controller.value * 20),
                  height: 14 + (_controller.value * 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withValues(
                        alpha: 0.3 - (_controller.value * 0.3)),
                  ),
                ),
                Container(
                  width: 12, height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const Positioned(
                  right: 0,
                  child: Text('En ligne',
                      style: TextStyle(
                          fontSize: 8,
                          color: Colors.green,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            );
          },
        );

      default:
        return Container(
          width: 30, height: 30,
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
            shape: BoxShape.circle,
          ),
        );
    }
  }
}