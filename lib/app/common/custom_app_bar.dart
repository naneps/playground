import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/theme.dart';
import 'package:playground/app/modules/core/controllers/core_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatefulWidget {
  final void Function()? onLeadingTap;
  const CustomAppBar({
    super.key,
    this.onLeadingTap,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [],
      ),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        subtitle: Text(
          DateFormat('EEEE, dd MMM yyyy').format(DateTime.now()),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        title: Text.rich(
          TextSpan(
            text: 'PLAY ',
            style: TextStyle(
              color: ThemeApp().primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            children: const [
              TextSpan(
                text: 'GROUND',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            if (widget.onLeadingTap != null) {
              widget.onLeadingTap!();
            }
            Get.find<CoreController>().zoomController.toggle!();
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.zero,
            foregroundColor: ThemeApp().primaryColor,
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // switch light/dark theme
                Switch.adaptive(
                  value: Get.isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      print('ThemeMode: ${value ? 'dark' : 'light'}');
                      Get.changeThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(MdiIcons.github),
                  onPressed: () async {
                    await gotoGithub();
                  },
                ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> gotoGithub() async {
    await launchUrl(Uri.parse('https://github.com/naneps/playground'));
  }
}
