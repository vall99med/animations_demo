import 'package:flutter/material.dart';

class ChoixParametresPage extends StatefulWidget {
  final String selectedTransition;
  final ValueChanged<String> onTransitionChanged;

  const ChoixParametresPage({
    super.key,
    required this.selectedTransition,
    required this.onTransitionChanged,
  });

  @override
  State<ChoixParametresPage> createState() =>
      _ChoixParametresPageState();
}

class _ChoixParametresPageState
    extends State<ChoixParametresPage> {
  final List<Map<String, dynamic>> transitions = const [
    {
      'name': 'Fade',
      'icon': Icons.opacity,
      'desc': 'Apparition progressive',
      'color': Colors.deepPurple,
    },
    {
      'name': 'Slide',
      'icon': Icons.arrow_forward,
      'desc': 'Glissement depuis la droite',
      'color': Colors.blue,
    },
    {
      'name': 'Slide bas',
      'icon': Icons.arrow_downward,
      'desc': 'Glissement depuis le bas',
      'color': Colors.indigo,
    },
    {
      'name': 'Scale',
      'icon': Icons.zoom_in,
      'desc': 'Zoom depuis le centre',
      'color': Colors.teal,
    },
    {
      'name': 'Rotation',
      'icon': Icons.rotate_right,
      'desc': 'Rotation en entrée',
      'color': Colors.orange,
    },
    {
      'name': 'Fade + Slide',
      'icon': Icons.auto_awesome,
      'desc': 'Combo fade et slide',
      'color': Colors.pink,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 8),
          child: Text(
            'Choisir la transition pour la ListView',
            style: TextStyle(
                fontSize: 13, color: Colors.grey.shade500),
          ),
        ),
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Transitions disponibles',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: transitions.length,
            itemBuilder: (context, index) {
              final t = transitions[index];
              final isSelected =
                  widget.selectedTransition == t['name'];
              return GestureDetector(
                onTap: () => widget
                    .onTransitionChanged(t['name'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (t['color'] as Color)
                            .withValues(alpha: 0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? t['color'] as Color
                          : Colors.grey.shade200,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48, height: 48,
                        decoration: BoxDecoration(
                          color: (t['color'] as Color)
                              .withValues(alpha: 0.15),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Icon(t['icon'] as IconData,
                            color: t['color'] as Color),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              t['name'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isSelected
                                    ? t['color'] as Color
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              t['desc'] as String,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 300),
                        width: 24, height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? t['color'] as Color
                              : Colors.transparent,
                          border: Border.all(
                            color: isSelected
                                ? t['color'] as Color
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check,
                                color: Colors.white, size: 14)
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Transition "${widget.selectedTransition}" appliquée!'),
                    backgroundColor: Colors.deepPurple,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              child: const Text(
                'Appliquer',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}