import 'package:flutter/material.dart';
import 'pages/animated_container_page.dart';
import 'pages/animation_controller_page.dart';
import 'pages/tween_page.dart';
import 'pages/animated_builder_page.dart';
import 'pages/transitions_page.dart';

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

  final List<Widget> pages = const [
    AnimatedContainerPage(),
    AnimationControllerPage(),
    TweenPage(),
    AnimatedBuilderPage(),
    TransitionsPage(),
  ];

  final List<Map<String, dynamic>> tabs = const [
    {'icon': Icons.crop_square,  'label': 'Container'},
    {'icon': Icons.play_arrow,   'label': 'Controller'},
    {'icon': Icons.swap_horiz,   'label': 'Tween'},
    {'icon': Icons.settings,     'label': 'Builder'},
    {'icon': Icons.flip,         'label': 'Transitions'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tabs[currentIndex]['label']),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios_new),
        actions: const [
           Icon(Icons.search),
           SizedBox(width: 15),
           Icon(Icons.more_vert),
           SizedBox(width: 10),
       ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: (index) => setState(() => currentIndex = index),
        items: tabs.map((tab) => BottomNavigationBarItem(
          icon: Icon(tab['icon']),
          label: tab['label'],
        )).toList(),
      ),
    );
  }
}