import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/ui/responsive_layout.dart';
import 'package:playground/app/modules/gradient_generator/views/gradient_preview_view.dart';
import 'package:playground/app/modules/gradient_generator/views/tools_bar_gradient_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/gradient_generator_controller.dart';

class GradientGeneratorView extends GetView<GradientGeneratorController> {
  const GradientGeneratorView({super.key});
  Future<void> _launchURL() async {
    const url = 'https://github.com/naneps/playground';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GRADIENT GENERATOR'),
          automaticallyImplyLeading: false,
          actions: [
            // github icon to
            IconButton(
              icon: Icon(MdiIcons.github),
              onPressed: () {
                _launchURL();
              },
            )
          ],
          centerTitle: true,
        ),
        body: const ResponsiveLayout(
          mobile: Column(
            children: [
              Expanded(child: GradientPreviewView()),
              Expanded(child: ToolsBarGradientView())
            ],
          ),
          tablet: Row(
            children: [
              Expanded(child: GradientPreviewView()),
              Expanded(child: ToolsBarGradientView())
            ],
          ),
          desktop: Row(
            children: [
              Expanded(child: GradientPreviewView()),
              Expanded(child: ToolsBarGradientView())
            ],
          ),
        ));
  }
}
