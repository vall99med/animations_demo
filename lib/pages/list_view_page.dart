import 'package:flutter/material.dart';
import '../widgets/concept_card.dart';
import '../widgets/concept_detail_page.dart';

class ListViewPage extends StatefulWidget {
  final String selectedTransition;

  const ListViewPage({
    super.key,
    required this.selectedTransition,
  });

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  String _selectedChip = 'Tous';
  int _chipKey = 0;

  final List<Map<String, dynamic>> concepts = const [
    {
      'concept': 'AnimatedContainer',
      'category': 'Implicit',
      'color': Colors.blue,
      'icon': Icons.crop_square,
      'difficulty': 'Facile',
      'difficultyColor': Colors.green,
      'useCases': [
        {
          'title': 'Carte expansible',
          'desc': 'Tap pour voir plus de détails',
          'demo': 'expandable_card',
        },
        {
          'title': 'Bouton press',
          'desc': 'Feedback visuel au tap',
          'demo': 'press_button',
        },
        {
          'title': 'Dark/Light toggle',
          'desc': 'Changement de thème animé',
          'demo': 'dark_toggle',
        },
      ],
    },
    {
      'concept': 'AnimationController',
      'category': 'Explicit',
      'color': Colors.green,
      'icon': Icons.play_arrow,
      'difficulty': 'Moyen',
      'difficultyColor': Colors.orange,
      'useCases': [
        {
          'title': 'Bouton de chargement',
          'desc': 'Envoyer → spinner → ✓',
          'demo': 'loading_button',
        },
        {
          'title': 'Splash screen',
          'desc': 'Animation au démarrage',
          'demo': 'splash',
        },
        {
          'title': 'Shake erreur',
          'desc': 'Formulaire invalide',
          'demo': 'shake',
        },
      ],
    },
    {
      'concept': 'Tween',
      'category': 'Explicit',
      'color': Colors.orange,
      'icon': Icons.swap_horiz,
      'difficulty': 'Moyen',
      'difficultyColor': Colors.orange,
      'useCases': [
        {
          'title': 'Barres de compétences',
          'desc': 'Progression animée',
          'demo': 'skills',
        },
        {
          'title': 'Compteur animé',
          'desc': '0 → 1250 abonnés',
          'demo': 'counter',
        },
        {
          'title': 'Transition couleur',
          'desc': 'Rouge → vert validation',
          'demo': 'color_transition',
        },
      ],
    },
    {
      'concept': 'AnimatedBuilder',
      'category': 'Explicit',
      'color': Colors.purple,
      'icon': Icons.build,
      'difficulty': 'Avancé',
      'difficultyColor': Colors.red,
      'useCases': [
        {
          'title': 'Spinner custom',
          'desc': 'Indicateur de chargement',
          'demo': 'spinner',
        },
        {
          'title': 'Barre progression',
          'desc': 'Téléchargement animé',
          'demo': 'progress',
        },
        {
          'title': 'Effet de vague',
          'desc': 'Signal WiFi / live',
          'demo': 'wave',
        },
      ],
    },
    {
      'concept': 'Page Transitions',
      'category': 'Navigation',
      'color': Colors.teal,
      'icon': Icons.flip,
      'difficulty': 'Moyen',
      'difficultyColor': Colors.orange,
      'useCases': [
        {
          'title': 'Fade',
          'desc': 'Apparition progressive',
          'demo': 'fade_transition',
        },
        {
          'title': 'Slide',
          'desc': 'Glissement depuis la droite',
          'demo': 'slide_transition',
        },
        {
          'title': 'Scale',
          'desc': 'Zoom depuis le centre',
          'demo': 'scale_transition',
        },
      ],
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_selectedChip == 'Tous') return concepts;
    return concepts
        .where((c) => c['category'] == _selectedChip)
        .toList();
  }

  Widget _applyTransition(
      Widget child, Animation<double> anim) {
    switch (widget.selectedTransition) {
      case 'Slide':
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        );
      case 'Slide bas':
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        );
      case 'Scale':
        return ScaleTransition(scale: anim, child: child);
      case 'Rotation':
        return RotationTransition(turns: anim, child: child);
      case 'Fade + Slide':
        return FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
        );
      case 'Fade':
      default:
        return FadeTransition(opacity: anim, child: child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 8),
          child: Text(
            '${concepts.length} concepts · 15 cas d\'usage',
            style: TextStyle(
                fontSize: 13, color: Colors.grey.shade500),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(horizontal: 16),
            children:
                ['Tous', 'Implicit', 'Explicit', 'Navigation']
                    .map((chip) => _buildChip(chip))
                    .toList(),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, anim) =>
                _applyTransition(child, anim),
            child: KeyedSubtree(
              key: ValueKey(_chipKey),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16),
                itemCount: _filtered.length,
                itemBuilder: (context, index) {
                  return ConceptCard(
                    concept: _filtered[index],
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration:
                            const Duration(milliseconds: 500),
                        pageBuilder: (context, anim, _) =>
                            ConceptDetailPage(
                                concept: _filtered[index]),
                        transitionsBuilder:
                            (context, anim, _, child) =>
                                _applyTransition(child, anim),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    final isSelected = _selectedChip == label;
    return GestureDetector(
      onTap: () {
        if (_selectedChip != label) {
          setState(() {
            _selectedChip = label;
            _chipKey++;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepPurple
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.grey.shade600,
            fontWeight: isSelected
                ? FontWeight.w600
                : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}