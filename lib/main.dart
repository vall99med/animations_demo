import 'package:flutter/material.dart';
import 'pages/animations.dart';
import 'pages/list_view_page.dart';
import 'pages/choix_parametres.dart';
import 'widgets/custom_navbar.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  String selectedTransition = 'Fade';

  final List<String> titles = const [
    'motion_kit',
    'Concepts',
    'Paramètres',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const AnimationsPage(),
      ListViewPage(selectedTransition: selectedTransition),
      ChoixParametresPage(
        selectedTransition: selectedTransition,
        onTransitionChanged: (value) {
          setState(() => selectedTransition = value);
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios_new,
            color: Colors.white),
        title: Text(
          titles[currentIndex],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          if (currentIndex == 1)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                selectedTransition,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            )
          else ...[
            const Icon(Icons.search, color: Colors.white),
            const SizedBox(width: 15),
            const Icon(Icons.more_vert, color: Colors.white),
            const SizedBox(width: 10),
          ],
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, anim) =>
            _applyTransition(child, anim),
        child: KeyedSubtree(
          key: ValueKey(currentIndex),
          child: pages[currentIndex],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }

  Widget _applyTransition(
      Widget child, Animation<double> anim) {
    switch (selectedTransition) {
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
}