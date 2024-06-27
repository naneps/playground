import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/theme.dart';
import 'package:playground/app/models/navigation.model.dart';

class NavigationTile extends StatelessWidget {
  final NavigationModel item;
  final void Function()? onTap;
  final bool isActive;
  final String? badge;
  const NavigationTile({
    super.key,
    required this.item,
    this.onTap,
    this.isActive = false,
    this.badge = '',
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color:
            isActive ? ThemeApp().primaryColor.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            color: isActive ? ThemeApp().primaryColor : Colors.white,
            width: 5,
          ),
        ),
      ),
      child: ListTile(
          leading: Icon(
            item.iconData,
            color: isActive ? ThemeApp().primaryColor : ThemeApp().black,
          ),
          dense: true,
          visualDensity: VisualDensity.compact,
          title: Text(
            item.title!,
            style: Get.textTheme.labelMedium!.copyWith(
              color: isActive ? ThemeApp().primaryColor : ThemeApp().black,
            ),
          ),
          onTap: onTap,
          trailing: badge!.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ThemeApp().primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    badge!,
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              : null),
    );
  }
}
