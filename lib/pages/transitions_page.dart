import 'package:flutter/material.dart';

class TransitionsPage extends StatelessWidget {
  const TransitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [

        _sectionTitle('1. Fade Transition'),
        _sectionDesc('Apparition progressive — idéal pour les modales'),
        const SizedBox(height: 12),
        _transitionButton(
          context,
          label: 'Ouvrir avec Fade',
          color: Colors.deepPurple,
          transition: (anim, child) => FadeTransition(
            opacity: anim,
            child: child,
          ),
        ),

        const SizedBox(height: 32),
        _sectionTitle('2. Slide Transition'),
        _sectionDesc('Glissement depuis la droite — navigation standard'),
        const SizedBox(height: 12),
        _transitionButton(
          context,
          label: 'Ouvrir avec Slide',
          color: Colors.blue,
          transition: (anim, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
        ),

        const SizedBox(height: 32),
        _sectionTitle('3. Scale Transition'),
        _sectionDesc('Zoom depuis le centre — détail d\'un élément'),
        const SizedBox(height: 12),
        _transitionButton(
          context,
          label: 'Ouvrir avec Scale',
          color: Colors.teal,
          transition: (anim, child) => ScaleTransition(
            scale: anim,
            child: child,
          ),
        ),

        const SizedBox(height: 32),
        _sectionTitle('4. Hero Transition'),
        _sectionDesc('L\'élément se transforme entre les deux pages'),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HeroDetailPage()),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.lightBlue.shade200),
            ),
            child: Row(
              children: [
                Hero(
                  tag: 'hero_image',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/liu.jpg',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lebanese International University',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tap pour agrandir',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _sectionDesc(String desc) {
    return Text(
      desc,
      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
    );
  }

  Widget _transitionButton(
    BuildContext context, {
    required String label,
    required Color color,
    required Widget Function(Animation<double>, Widget) transition,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (context, anim, secondAnim) =>
                DetailPage(label: label, color: color),
            transitionsBuilder: (context, anim, secondAnim, child) =>
                transition(anim, child),
          ),
        );
      },
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String label;
  final Color color;

  const DetailPage({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(label),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 80),
            const SizedBox(height: 24),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: color,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}

class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lebanese International University'),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'hero_image',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/liu.jpg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Lebanese International University',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Nouakchott, Mauritanie',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}