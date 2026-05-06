import 'package:flutter/material.dart';
import 'dart:math' as math;

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

  Widget _applyTransition(Widget child, Animation<double> anim) {
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
        // chips
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children:
                ['Tous', 'Implicit', 'Explicit', 'Navigation']
                    .map((chip) => _buildChip(chip))
                    .toList(),
          ),
        ),
        const SizedBox(height: 16),
        // animated list
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, anim) =>
                _applyTransition(child, anim),
            child: KeyedSubtree(
              key: ValueKey(_chipKey),
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filtered.length,
                itemBuilder: (context, index) {
                  return _buildConceptCard(
                      context, _filtered[index]);
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
            color:
                isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: isSelected
                ? FontWeight.w600
                : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildConceptCard(
      BuildContext context, Map<String, dynamic> concept) {
    final color = concept['color'] as Color;
    final useCases =
        concept['useCases'] as List<Map<String, dynamic>>;

    return GestureDetector(
      onTap: () => _navigateToDetail(context, concept),
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
                                color:
                                    color.withValues(alpha: 0.1),
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

  void _navigateToDetail(
      BuildContext context, Map<String, dynamic> concept) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, anim, secondAnim) =>
            _ConceptDetailPage(concept: concept),
        transitionsBuilder: (context, anim, secondAnim, child) =>
            _applyTransition(child, anim),
      ),
    );
  }
}

// ─── Concept Detail Page ─────────────────────────────────────────────────────

class _ConceptDetailPage extends StatelessWidget {
  final Map<String, dynamic> concept;

  const _ConceptDetailPage({required this.concept});

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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
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
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: (concept['difficultyColor']
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
                                  fontWeight: FontWeight.w600),
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
                  builder: (context) => _DemoSheet(
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
                                  color: Colors.grey.shade500),
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

// ─── Demo Bottom Sheet ───────────────────────────────────────────────────────

class _DemoSheet extends StatefulWidget {
  final String title;
  final String demo;
  final Color color;

  const _DemoSheet({
    required this.title,
    required this.demo,
    required this.color,
  });

  @override
  State<_DemoSheet> createState() => _DemoSheetState();
}

class _DemoSheetState extends State<_DemoSheet>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  bool _toggle = false;
  bool _isLoading = false;
  bool _isDone = false;
  bool _isDark = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    Duration duration;
    switch (widget.demo) {
      case 'counter':
        duration = const Duration(seconds: 2);
        break;
      case 'skills':
        duration = const Duration(milliseconds: 1500);
        break;
      case 'progress':
        duration = const Duration(seconds: 2);
        break;
      case 'color_transition':
        duration = const Duration(seconds: 1);
        break;
      default:
        duration = const Duration(milliseconds: 800);
    }

    _controller =
        AnimationController(vsync: this, duration: duration);
    _autoPlay();
  }

  void _autoPlay() {
    switch (widget.demo) {
      case 'spinner':
      case 'wave':
        _controller.repeat();
        break;
      case 'expandable_card':
      case 'dark_toggle':
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) setState(() => _toggle = true);
        });
        break;
      case 'skills':
      case 'counter':
      case 'progress':
      case 'splash':
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) _controller.forward();
        });
        break;
      case 'loading_button':
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() => _isLoading = true);
            _controller.forward().then((_) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                  _isDone = true;
                });
              }
            });
          }
        });
        break;
      case 'shake':
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            _controller.repeat(reverse: true);
            Future.delayed(
                const Duration(milliseconds: 600), () {
              if (mounted) _controller.stop();
            });
          }
        });
        break;
    }
  }

  void _replay() {
    setState(() {
      _toggle = false;
      _isLoading = false;
      _isDone = false;
      _isDark = false;
    });
    _controller.reset();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _autoPlay();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: _replay,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.replay, size: 14),
                        SizedBox(width: 4),
                        Text('Replay',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.grey.shade100),
          Expanded(
            child: Center(child: _buildDemo()),
          ),
        ],
      ),
    );
  }

  Widget _buildDemo() {
    switch (widget.demo) {

      case 'expandable_card':
        return GestureDetector(
          onTap: () => setState(() => _toggle = !_toggle),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            width: 260,
            height: _toggle ? 140 : 60,
            decoration: BoxDecoration(
              color: widget.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: widget.color.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, color: widget.color),
                    const SizedBox(width: 8),
                    const Text('Ahmed Vall',
                        style: TextStyle(
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    AnimatedRotation(
                      turns: _toggle ? 0.5 : 0,
                      duration:
                          const Duration(milliseconds: 400),
                      child: Icon(Icons.keyboard_arrow_down,
                          color: widget.color),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
                if (_toggle) ...[
                  const Divider(),
                  Text('Flutter Developer',
                      style: TextStyle(
                          color: Colors.grey.shade600)),
                  Text('Nouakchott, Mauritanie',
                      style: TextStyle(
                          color: Colors.grey.shade600)),
                ],
              ],
            ),
          ),
        );

      case 'press_button':
        return GestureDetector(
          onTapDown: (_) =>
              setState(() => _isPressed = true),
          onTapUp: (_) =>
              setState(() => _isPressed = false),
          onTapCancel: () =>
              setState(() => _isPressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: _isPressed ? 160 : 200,
            height: _isPressed ? 48 : 56,
            decoration: BoxDecoration(
              color: _isPressed
                  ? widget.color.withValues(alpha: 0.7)
                  : widget.color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: _isPressed ? [] : [
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Center(
              child: Text('Appuyer',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ),
          ),
        );

      case 'dark_toggle':
        return GestureDetector(
          onTap: () => setState(() => _isDark = !_isDark),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: 260,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isDark
                  ? Colors.grey.shade900
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border:
                  Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isDark ? '🌙 Mode sombre' : '☀️ Mode clair',
                  style: TextStyle(
                      color: _isDark
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 48, height: 26,
                  decoration: BoxDecoration(
                    color: _isDark
                        ? widget.color
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: AnimatedAlign(
                    duration:
                        const Duration(milliseconds: 400),
                    alignment: _isDark
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 22, height: 22,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 2),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      case 'loading_button':
        return GestureDetector(
          onTap: () {
            if (_isDone) {
              setState(() {
                _isDone = false;
                _isLoading = false;
              });
              _controller.reset();
              Future.delayed(
                  const Duration(milliseconds: 200),
                  _autoPlay);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isLoading ? 60 : 200,
            height: 60,
            decoration: BoxDecoration(
              color: _isDone ? Colors.green : widget.color,
              borderRadius: BorderRadius.circular(
                  _isLoading ? 30 : 16),
            ),
            child: Center(
              child: _isDone
                  ? const Icon(Icons.check,
                      color: Colors.white, size: 28)
                  : _isLoading
                      ? AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return SizedBox(
                              width: 24, height: 24,
                              child:
                                  CircularProgressIndicator(
                                value: _controller.value,
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            );
                          },
                        )
                      : const Text('Envoyer',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
            ),
          ),
        );

      case 'splash':
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _controller.value,
              child: Transform.scale(
                scale: 0.5 + (_controller.value * 0.5),
                child: Container(
                  width: 90, height: 90,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.flutter_dash,
                      color: Colors.white, size: 50),
                ),
              ),
            );
          },
        );

      case 'shake':
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final shake =
                ((_controller.value * 10).floor() % 2 == 0
                        ? 1
                        : -1) *
                    _controller.value * 8;
            return Transform.translate(
              offset: Offset(shake, 0),
              child: Container(
                width: 240, height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: _controller.value > 0
                        ? Colors.red
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _controller.value > 0
                          ? Icons.error_outline
                          : Icons.lock_outline,
                      color: _controller.value > 0
                          ? Colors.red
                          : Colors.grey,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _controller.value > 0
                          ? 'Mot de passe incorrect!'
                          : 'Mot de passe',
                      style: TextStyle(
                          color: _controller.value > 0
                              ? Colors.red
                              : Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        );

      case 'skills':
        final skills = [
          {'label': 'Flutter', 'level': 0.9},
          {'label': 'Dart', 'level': 0.75},
        ];
        return SizedBox(
          width: 260,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: skills.map((skill) {
              final anim = Tween<double>(
                      begin: 0,
                      end: skill['level'] as double)
                  .animate(CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeOutCubic));
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(skill['label'] as String,
                            style: const TextStyle(
                                fontWeight:
                                    FontWeight.w600)),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) =>
                              Text(
                                  '${(anim.value * 100).toInt()}%',
                                  style: TextStyle(
                                      color: Colors
                                          .grey.shade600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) =>
                            FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: anim.value,
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.color,
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );

      case 'counter':
        final counterAnim =
            Tween<double>(begin: 0, end: 1250).animate(
          CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOutCubic),
        );
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${counterAnim.value.toInt()}',
                  style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: widget.color),
                ),
                Text('Abonnés',
                    style: TextStyle(
                        color: Colors.grey.shade500)),
              ],
            );
          },
        );

      case 'color_transition':
        final colorAnim = ColorTween(
                begin: Colors.red, end: Colors.green)
            .animate(_controller);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 90, height: 90,
                  decoration: BoxDecoration(
                    color: colorAnim.value,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _controller.value > 0.5 ? '✓' : '✗',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white),
                  onPressed: () => _controller.forward(),
                  child: const Text('Valider'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white),
                  onPressed: () => _controller.reverse(),
                  child: const Text('Invalider'),
                ),
              ],
            ),
          ],
        );

      case 'spinner':
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SizedBox(
              width: 60, height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(8, (index) {
                  final angle = (index / 8) * 2 * math.pi;
                  final opacity =
                      (((_controller.value * 8) - index) %
                              8) /
                          8;
                  return Positioned(
                    left: 22 + math.cos(angle) * 20,
                    top: 22 + math.sin(angle) * 20,
                    child: Opacity(
                      opacity: opacity.clamp(0.1, 1.0),
                      child: Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(
                            color: widget.color,
                            shape: BoxShape.circle),
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        );

      case 'progress':
        return SizedBox(
          width: 260,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _controller.value,
                      backgroundColor: Colors.grey.shade200,
                      color: widget.color,
                      minHeight: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(_controller.value * 100).toInt()}%',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.color),
                  ),
                ],
              );
            },
          ),
        );

      case 'wave':
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SizedBox(
              width: 120, height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ...List.generate(3, (index) {
                    final delay = index / 3;
                    final value =
                        (_controller.value + delay) % 1.0;
                    return Container(
                      width: 30 + (value * 80),
                      height: 30 + (value * 80),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.color
                              .withValues(alpha: 1 - value),
                          width: 2,
                        ),
                      ),
                    );
                  }),
                  Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(
                        color: widget.color,
                        shape: BoxShape.circle),
                    child: const Icon(Icons.wifi,
                        color: Colors.white, size: 16),
                  ),
                ],
              ),
            );
          },
        );

      case 'fade_transition':
      case 'slide_transition':
      case 'scale_transition':
        final transitionName =
            widget.demo == 'fade_transition'
                ? 'Fade'
                : widget.demo == 'slide_transition'
                    ? 'Slide'
                    : 'Scale';
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            foregroundColor: Colors.white,
            minimumSize: const Size(200, 55),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration:
                    const Duration(milliseconds: 600),
                pageBuilder: (context, anim, _) =>
                    _TransitionDemoPage(
                        color: widget.color,
                        name: transitionName),
                transitionsBuilder:
                    (context, anim, _, child) {
                  switch (widget.demo) {
                    case 'slide_transition':
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      );
                    case 'scale_transition':
                      return ScaleTransition(
                          scale: anim, child: child);
                    case 'fade_transition':
                    default:
                      return FadeTransition(
                          opacity: anim, child: child);
                  }
                },
              ),
            );
          },
          child: Text('Tester $transitionName',
              style: const TextStyle(fontSize: 16)),
        );

      default:
        return const Text('Demo non disponible');
    }
  }
}

class _TransitionDemoPage extends StatelessWidget {
  final Color color;
  final String name;

  const _TransitionDemoPage(
      {required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        foregroundColor: Colors.white,
        title: Text('$name Transition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle,
                color: Colors.white, size: 80),
            const SizedBox(height: 16),
            Text(name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: color),
              onPressed: () => Navigator.pop(context),
              child: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}