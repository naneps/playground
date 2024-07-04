import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/custom_app_bar.dart';
import 'package:playground/app/modules/post/views/post_list_view.dart';
import 'package:playground/app/modules/post/widgets/filter_post.dart';

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
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              const SizedBox(width: 20),
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
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    boxShadow: [],
                  ),
                ),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
