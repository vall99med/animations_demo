// animation_controller_page.dart
import 'package:flutter/material.dart';

class AnimationControllerPage extends StatefulWidget {
  const AnimationControllerPage({super.key});

  @override
  State<AnimationControllerPage> createState() => _AnimationControllerPageState();
}

class _AnimationControllerPageState extends State<AnimationControllerPage>
    with TickerProviderStateMixin {

  late AnimationController _loadingController;
  late AnimationController _splashController;
  late AnimationController _shakeController;

  bool _isLoading = false;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() { _isLoading = false; _isDone = true; });
      }
    });

    _splashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _splashController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [

        _sectionTitle('1. Bouton de chargement'),
        _sectionDesc('Tap pour simuler un envoi'),
        const SizedBox(height: 16),
        Center(
          child: GestureDetector(
            onTap: () {
              if (_isDone) {
                setState(() { _isDone = false; _isLoading = false; });
                _loadingController.reset();
              } else if (!_isLoading) {
                setState(() => _isLoading = true);
                _loadingController.forward();
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _isLoading ? 60 : 200,
              height: 60,
              decoration: BoxDecoration(
                color: _isDone ? Colors.green : Colors.deepPurple,
                borderRadius: BorderRadius.circular(_isLoading ? 30 : 16),
              ),
              child: Center(
                child: _isDone
                    ? const Icon(Icons.check, color: Colors.white, size: 28)
                    : _isLoading
                        ? AnimatedBuilder(
                            animation: _loadingController,
                            builder: (context, child) {
                              return SizedBox(
                                width: 24, height: 24,
                                child: CircularProgressIndicator(
                                  value: _loadingController.value,
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              );
                            },
                          )
                        : const Text('Envoyer',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            _isDone ? 'Tap pour recommencer' : _isLoading ? 'Envoi...' : '',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
        ),

        const SizedBox(height: 40),
        _sectionTitle('2. Splash animation'),
        _sectionDesc('Tap pour rejouer l\'animation de démarrage'),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _splashController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _splashController.value,
                    child: Transform.scale(
                      scale: 0.5 + (_splashController.value * 0.5),
                      child: Container(
                        width: 100, height: 100,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(Icons.flutter_dash,
                            color: Colors.white, size: 50),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _splashController.reset();
                  _splashController.forward();
                },
                child: const Text('Jouer'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40),
        _sectionTitle('3. Shake — erreur formulaire'),
        _sectionDesc('Tap pour simuler une erreur de saisie'),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _shakeController,
                builder: (context, child) {
                  final shake = ((_shakeController.value * 10).floor() % 2 == 0 ? 1 : -1)
                      * _shakeController.value * 8;
                  return Transform.translate(
                    offset: Offset(shake, 0),
                    child: Container(
                      width: 280, height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: _shakeController.value > 0
                              ? Colors.red
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          Icon(
                            _shakeController.value > 0
                                ? Icons.error_outline
                                : Icons.lock_outline,
                            color: _shakeController.value > 0
                                ? Colors.red
                                : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _shakeController.value > 0
                                ? 'Mot de passe incorrect!'
                                : 'Mot de passe',
                            style: TextStyle(
                              color: _shakeController.value > 0
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _shakeController.reset();
                  _shakeController.repeat(reverse: true);
                  Future.delayed(
                    const Duration(milliseconds: 500),
                    () {
                      if (mounted) _shakeController.stop();
                    },
                  );
                },
                child: const Text('Simuler erreur'),
              ),
            ],
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