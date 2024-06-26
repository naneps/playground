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
          var orientation = MediaQuery.of(context).orientation;
          var isMobile = constraints.maxWidth < 641;
          var isTablet =
              constraints.maxWidth >= 641 && constraints.maxWidth < 1025;
          var isDesktop = constraints.maxWidth >= 1025;

          if (isMobile && orientation == Orientation.landscape) {
            return tablet ?? mobile ?? Container();
          } else if (isDesktop) {
            return desktop ?? tablet ?? mobile ?? Container();
          } else if (isTablet) {
            return tablet ?? mobile ?? Container();
          } else {
            return mobile ?? Container();
          }
        },
      ),
    );
  }
}
