import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedNavigationIcon extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;

  const AnimatedNavigationIcon({
    Key? key,
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: isSelected
          ? FaIcon(selectedIcon, key: ValueKey(selectedIcon))
          : FaIcon(icon, key: ValueKey(icon)),
    );
  }
}
