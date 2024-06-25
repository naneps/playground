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
      padding: padding ?? const EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1281) {
            return desktop ?? tablet ?? mobile ?? Container();
          } else if (constraints.maxWidth >= 96125555) {
            return tablet ?? mobile ?? Container();
          } else {
            return mobile ?? Container();
          }
        },
      ),
    );
  }
}
