import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<Map<String, dynamic>> tabs = const [
    {'icon': Icons.animation,  'label': 'Motion'},
    {'icon': Icons.list,       'label': 'Concepts'},
    {'icon': Icons.tune,       'label': 'Paramètres'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          tabs.length,
          (index) => _navItem(index),
        ),
      ),
    );
  }

  Widget _navItem(int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepPurple.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: Icon(
                tabs[index]['icon'] as IconData,
                color: isSelected ? Colors.deepPurple : Colors.grey,
                size: isSelected ? 26 : 22,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: isSelected
                  ? Row(
                      children: [
                        const SizedBox(width: 8),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          opacity: isSelected ? 1.0 : 0.0,
                          child: Text(
                            tabs[index]['label'] as String,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}