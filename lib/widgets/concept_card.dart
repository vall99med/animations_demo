import 'package:flutter/material.dart';

class ConceptCard extends StatelessWidget {
  final Map<String, dynamic> concept;
  final VoidCallback onTap;

  const ConceptCard({
    super.key,
    required this.concept,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = concept['color'] as Color;
    final useCases =
        concept['useCases'] as List<Map<String, dynamic>>;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 52, height: 52,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(concept['icon'] as IconData,
                        color: color, size: 26),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          concept['concept'] as String,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3),
                              decoration: BoxDecoration(
                                color: color
                                    .withValues(alpha: 0.1),
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
                                concept['difficulty']
                                    as String,
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
                  Column(
                    children: [
                      Icon(Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey.shade400),
                      const SizedBox(height: 4),
                      Text(
                        '${useCases.length} cas',
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade100),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: useCases.map((uc) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 6, height: 6,
                          decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                uc['title'] as String,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                              ),
                              Text(
                                uc['desc'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color:
                                        Colors.grey.shade500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}