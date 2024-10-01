import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/custom_app_bar.dart';
import 'package:playground/app/common/ui/items_card/item_grid.widget.dart';
import 'package:playground/app/common/ui/items_card/item_tile.widget.dart';
import 'package:playground/app/common/ui/responsive_layout.dart';

import '../controllers/ui_components_controller.dart';

class UiComponentsView extends GetView<UiComponentsController> {
  const UiComponentsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: ResponsiveLayout(
              mobile: const Column(
                children: [],
              ),
              tablet: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.red.shade400,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: GridView.builder(
                            padding: const EdgeInsets.all(10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return const ItemGrid();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return const ItemTile();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.red.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
