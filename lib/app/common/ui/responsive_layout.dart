import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final EdgeInsetsGeometry? padding;

  const ResponsiveLayout({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          var isMobile = constraints.maxWidth <= 480;
          var isTablet =
              constraints.maxWidth > 480 && constraints.maxWidth <= 1024;
          var isDesktop = constraints.maxWidth > 1024;

          Widget currentChild;
          if (isMobile) {
            currentChild = mobile ?? Container();
          } else if (isTablet) {
            currentChild = tablet ?? mobile ?? Container();
          } else if (isDesktop) {
            currentChild = desktop ?? tablet ?? mobile ?? Container();
          } else {
            currentChild = Container(); // Fallback, though unlikely to reach
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            switchInCurve: Curves.easeInOutCubic,
            child: currentChild,
          );
        },
      ),
    );
  }
}
