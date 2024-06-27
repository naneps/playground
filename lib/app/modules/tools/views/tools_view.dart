import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tools_controller.dart';

class ToolsView extends GetView<ToolsController> {
  const ToolsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3,
                    ),
                    itemCount: controller.navigationList.length,
                    itemBuilder: (context, index) {
                      final item = controller.navigationList[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(item.route!);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item.iconData,
                                size: 50,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item.title!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
