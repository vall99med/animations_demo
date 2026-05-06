import 'package:flutter/material.dart';
import '../widgets/animation_card.dart';

class AnimationsPage extends StatefulWidget {
  const AnimationsPage({super.key});

  @override
  State<AnimationsPage> createState() => _AnimationsPageState();
}

class _AnimationsPageState extends State<AnimationsPage> {
  int _replayKey = 0;

  final List<Map<String, dynamic>> cards = const [
    {
      'title': 'Fade',
      'type': 'Container',
      'typeColor': Colors.blue,
      'useCase': 'Notification apparaît',
    },
    {
      'title': 'Scale',
      'type': 'Container',
      'typeColor': Colors.blue,
      'useCase': 'Bouton like',
    },
    {
      'title': 'Slide',
      'type': 'Container',
      'typeColor': Colors.blue,
      'useCase': 'Message entrant',
    },
    {
      'title': 'Rotate',
      'type': 'Controller',
      'typeColor': Colors.green,
      'useCase': 'Icône de sync',
    },
    {
      'title': 'Bounce',
      'type': 'Builder',
      'typeColor': Colors.orange,
      'useCase': 'Badge notification',
    },
    {
      'title': 'Pulse',
      'type': 'Controller',
      'typeColor': Colors.green,
      'useCase': 'Indicateur en ligne',
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${cards.length} animations · built-in',
                style: TextStyle(
                    fontSize: 13, color: Colors.grey.shade500),
              ),
              GestureDetector(
                onTap: () => setState(() => _replayKey++),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.replay, size: 16),
                      SizedBox(width: 6),
                      Text('Replay',
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.9,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return AnimationCard(
                  key: ValueKey(
                      '${cards[index]['title']}_$_replayKey'),
                  title: cards[index]['title'] as String,
                  type: cards[index]['type'] as String,
                  typeColor: cards[index]['typeColor'] as Color,
                  useCase: cards[index]['useCase'] as String,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}