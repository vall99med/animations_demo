// animated_builder_page.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBuilderPage extends StatefulWidget {
  const AnimatedBuilderPage({super.key});

  @override
  State<AnimatedBuilderPage> createState() => _AnimatedBuilderPageState();
}

class _AnimatedBuilderPageState extends State<AnimatedBuilderPage>
    with TickerProviderStateMixin {

  late AnimationController _spinnerController;
  late AnimationController _progressController;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();

    _spinnerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _spinnerController.dispose();
    _progressController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [

        _sectionTitle('1. Spinner personnalisé'),
        _sectionDesc('AnimatedBuilder reconstruit à chaque frame'),
        const SizedBox(height: 24),
        Center(
          child: AnimatedBuilder(
            animation: _spinnerController,
            builder: (context, child) {
              return SizedBox(
                width: 80, height: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: List.generate(8, (index) {
                    final angle = (index / 8) * 2 * math.pi;
                    final opacity =
                        (((_spinnerController.value * 8) - index) % 8) / 8;
                    return Positioned(
                      left: 30 + math.cos(angle) * 28,
                      top: 30 + math.sin(angle) * 28,
                      child: Opacity(
                        opacity: opacity.clamp(0.1, 1.0),
                        child: Container(
                          width: 10, height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.deepPurple,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 40),
        _sectionTitle('2. Barre de progression'),
        _sectionDesc('Tap pour simuler un téléchargement'),
        const SizedBox(height: 16),
        AnimatedBuilder(
          animation: _progressController,
          builder: (context, child) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _progressController.value,
                    backgroundColor: Colors.grey.shade200,
                    color: Colors.deepPurple,
                    minHeight: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(_progressController.value * 100).toInt()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              _progressController.reset();
              _progressController.forward();
            },
            child: const Text('Télécharger'),
          ),
        ),

        const SizedBox(height: 40),
        _sectionTitle('3. Effet de vague'),
        _sectionDesc('Cercles concentriques animés en boucle'),
        const SizedBox(height: 24),
        Center(
          child: AnimatedBuilder(
            animation: _waveController,
            builder: (context, child) {
              return SizedBox(
                width: 150, height: 150,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ...List.generate(3, (index) {
                      final delay = index / 3;
                      final value = (_waveController.value + delay) % 1.0;
                      return Container(
                        width: 50 + (value * 100),
                        height: 50 + (value * 100),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.deepPurple.withOpacity(1 - value),
                            width: 2,
                          ),
                        ),
                      );
                    }),
                    Container(
                      width: 50, height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.wifi, color: Colors.white, size: 24),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ));
  }

  Widget _sectionDesc(String desc) {
    return Text(desc,
        style: TextStyle(fontSize: 13, color: Colors.grey.shade600));
  }
}