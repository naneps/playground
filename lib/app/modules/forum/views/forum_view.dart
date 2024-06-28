// forum_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/responsive_layout.dart';
import 'package:playground/app/modules/forum/controllers/forum_controller.dart';
import 'package:playground/app/modules/forum/widgets/post_widget.dart';

class ForumView extends GetView<ForumController> {
  const ForumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveLayout(
      mobile: const Column(),
      tablet: Row(
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Container(),
          )
        ],
      ),
      desktop: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [],
                    ),
                    child: Row(
                        // search and create post
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(10),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {},
                                  )),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 40),
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {},
                            child: const Text('Create Post'),
                          )
                        ]),
                  ),
                  Expanded(
                      child: ListView.separated(
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    itemCount: 10,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return const PostWidget();
                    },
                  ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          )
        ],
      ),
    ));
  }
}
