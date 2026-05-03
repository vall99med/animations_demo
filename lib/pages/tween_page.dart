// tween_page.dart
import 'package:flutter/material.dart';

class TweenPage extends StatefulWidget {
  const TweenPage({super.key});

  @override
  State<TweenPage> createState() => _TweenPageState();
}

class _TweenPageState extends State<TweenPage>
    with TickerProviderStateMixin {

  late AnimationController _skillsController;
  late AnimationController _counterController;
  late Animation<double> _counterAnimation;
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;

  final List<Map<String, dynamic>> skills = const [
    {'label': 'Flutter',   'level': 0.9},
    {'label': 'Dart',      'level': 0.8},
    {'label': 'Firebase',  'level': 0.6},
    {'label': 'UI Design', 'level': 0.7},
  ];

  @override
  void initState() {
    super.initState();

    _skillsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _counterController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _counterAnimation = Tween<double>(begin: 0, end: 1250)
        .animate(CurvedAnimation(
          parent: _counterController,
          curve: Curves.easeOutCubic,
        ));

    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.green,
    ).animate(_colorController);
  }

  @override
  void dispose() {
    _skillsController.dispose();
    _counterController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [

        _sectionTitle('1. Barres de compétences'),
        _sectionDesc('Tween<double> + ColorTween'),
        const SizedBox(height: 16),
        ...skills.map((skill) {
          final anim = Tween<double>(begin: 0, end: skill['level'])
              .animate(CurvedAnimation(
                parent: _skillsController,
                curve: Curves.easeOutCubic,
              ));
          final colorAnim = ColorTween(
            begin: Colors.deepPurple.shade200,
            end: skill['level'] > 0.7 ? Colors.deepPurple : Colors.orange,
          ).animate(_skillsController);

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(skill['label'],
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    AnimatedBuilder(
                      animation: _skillsController,
                      builder: (context, child) => Text(
                        '${(anim.value * 100).toInt()}%',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: AnimatedBuilder(
                    animation: _skillsController,
                    builder: (context, child) => FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: anim.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorAnim.value,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              _skillsController.reset();
              _skillsController.forward();
            },
            child: const Text('Rejouer'),
          ),
        ),

        const SizedBox(height: 40),
        _sectionTitle('2. Compteur animé'),
        _sectionDesc('Tween<double> pour animer un nombre'),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _counterController,
                builder: (context, child) {
                  return Text(
                    '${_counterAnimation.value.toInt()}',
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  );
                },
              ),
              const Text('Abonnés', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _counterController.reset();
                  _counterController.forward();
                },
                child: const Text('Compter'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40),
        _sectionTitle('3. Transition de couleur'),
        _sectionDesc('ColorTween entre rouge et vert'),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _colorController,
                builder: (context, child) {
                  return Container(
                    width: 120, height: 120,
                    decoration: BoxDecoration(
                      color: _colorAnimation.value,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _colorController.value > 0.5 ? '✓' : '✗',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _colorController.forward(),
                    child: const Text('Valider'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => _colorController.reverse(),
                    child: const Text('Invalider'),
                  ),
                ],
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