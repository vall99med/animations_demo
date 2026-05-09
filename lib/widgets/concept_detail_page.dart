import 'package:flutter/material.dart';
import 'demo_sheet.dart';

class ConceptDetailPage extends StatelessWidget {
  final Map<String, dynamic> concept;

  const ConceptDetailPage({
    super.key,
    required this.concept,
  });

  @override
  Widget build(BuildContext context) {
    final color = concept['color'] as Color;
    final useCases =
        concept['useCases'] as List<Map<String, dynamic>>;

    return Scaffold(
      appBar: AppBar(
        title: Text(concept['concept'] as String),
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(concept['icon'] as IconData,
                      color: color, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        concept['concept'] as String,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: color),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3),
                            decoration: BoxDecoration(
                              color:
                                  color.withValues(alpha: 0.2),
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            child: Text(
                              concept['category'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: color,
                                  fontWeight:
                                      FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3),
                            decoration: BoxDecoration(
                              color: (concept[
                                          'difficultyColor']
                                      as Color)
                                  .withValues(alpha: 0.1),
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            child: Text(
                              concept['difficulty'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: concept[
                                          'difficultyColor']
                                      as Color,
                                  fontWeight:
                                      FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Tap sur un cas pour voir la démo',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...useCases.map((uc) => GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => DemoSheet(
                    title: uc['title'] as String,
                    demo: uc['demo'] as String,
                    color: color,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(alpha: 0.03),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              uc['title'] as String,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              uc['desc'] as String,
                              style: TextStyle(
                                  fontSize: 13,
                                  color:
                                      Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.play_circle_outline,
                          color: color, size: 24),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}