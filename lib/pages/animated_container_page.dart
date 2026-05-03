import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {
  const AnimatedContainerPage({super.key});

  @override
  State<AnimatedContainerPage> createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  bool _isExpanded = false;
  bool _isPressed = false;
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      color: _isDark ? Colors.grey.shade900 : Colors.grey.shade50,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [

          _sectionTitle('1. Carte expansible'),
          _sectionDesc('Tap pour voir les détails du profil'),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: double.infinity,
              height: _isExpanded ? 220 : 80,
              decoration: BoxDecoration(
                color: _isDark ? Colors.grey.shade800 : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.deepPurple.shade100,
                          child: const Icon(Icons.person, color: Colors.deepPurple),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sidi Mohamed',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: _isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const Text('Etudiant Flutter',
                                style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                        const Spacer(),
                        AnimatedRotation(
                          turns: _isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 400),
                          child: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  if (_isExpanded) ...[
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    _infoRow(Icons.email, 'sidimed@email.com', _isDark),
                    _infoRow(Icons.phone, '+222 XX XX XX XX', _isDark),
                    _infoRow(Icons.location_on, 'Nouakchott, Mauritanie', _isDark),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),
          _sectionTitle('2. Bouton press'),
          _sectionDesc('Maintiens le bouton appuyé'),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                width: _isPressed ? 160 : 200,
                height: _isPressed ? 50 : 60,
                decoration: BoxDecoration(
                  color: _isPressed ? Colors.deepPurple.shade300 : Colors.deepPurple,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: _isPressed ? [] : [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Appuyer',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
          _sectionTitle('3. Dark / Light toggle'),
          _sectionDesc('Tap pour changer le thème de cette page'),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => setState(() => _isDark = !_isDark),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _isDark ? Colors.grey.shade800 : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isDark ? '🌙 Mode sombre' : '☀️ Mode clair',
                    style: TextStyle(
                      color: _isDark ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                    value: _isDark,
                    onChanged: (_) => setState(() => _isDark = !_isDark),
                    activeThumbColor: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white70 : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: _isDark ? Colors.white : Colors.deepPurple,
      ),
    );
  }

  Widget _sectionDesc(String desc) {
    return Text(
      desc,
      style: TextStyle(
        fontSize: 13,
        color: _isDark ? Colors.grey.shade400 : Colors.grey.shade600,
      ),
    );
  }
}