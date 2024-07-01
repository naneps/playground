import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/inputs/x_input.dart';
import 'package:playground/app/common/ui/overlays/scalled_dialog.dart';
import 'package:playground/app/modules/auth/views/auth_view.dart';

class FilterPost extends StatelessWidget {
  const FilterPost({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 600;
    int widthButton = 150;
    int heightButton = 50;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [],
      ),
      child: LayoutBuilder(builder: (context, constraint) {
        if (constraint.maxWidth < 600) {
          widthButton = 100;
          heightButton = 40;
        } else {
          widthButton = 150;
          heightButton = 50;
        }
        return Row(
          // search and create post

          children: [
            const Expanded(
              child: XInput(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(width: 10),
            Hero(
              tag: 'create_post',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  fixedSize:
                      Size(widthButton.toDouble(), heightButton.toDouble()),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  Get.dialog(ScaleDialog(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 5),
                      child: const AlertDialog(
                        scrollable: true,
                        backgroundColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                        content: AuthView(),
                      ),
                    ),
                  ));
                },
                child: Text(
                  'Create Post',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            IconButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
              ),
              icon: const Icon(Icons.filter_list),
              onPressed: () {},
            ),
          ],
        );
      }),
    );
  }
}
