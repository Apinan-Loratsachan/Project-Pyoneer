import "package:flutter/material.dart";

class PyoneerHero {
  static Hero hero(Widget child, String tag) {
    return Hero(
      flightShuttleBuilder: (_,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext) {
        return AnimatedBuilder(
          animation: animation,
          child: child,
          builder: (_, child) {
            return DefaultTextStyle.merge(
              child: child!,
              style: TextStyle.lerp(
                  // Ensure consistent text styles across contexts
                  TextStyle.lerp(
                      DefaultTextStyle.of(fromHeroContext).style,
                      DefaultTextStyle.of(toHeroContext).style,
                      0.5), // Use 0.5 for a smoother transition
                  DefaultTextStyle.of(toHeroContext).style,
                  animation.value),
            );
          },
        );
      },
      tag: tag,
      child: child,
    );
  }
}
