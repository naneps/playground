import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/custom_app_bar.dart';
import 'package:playground/app/modules/forum/views/post_list_view.dart';
import 'package:playground/app/modules/forum/widgets/filter_post.dart';

class ForumTabletView extends GetView {
  const ForumTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: CustomAppBar(),
        ),
        SliverFillRemaining(
            child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Column(
                  children: [],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: const CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      flexibleSpace: FilterPost(),
                    ),
                    PostListView(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ))
      ],
    );
  }
}
