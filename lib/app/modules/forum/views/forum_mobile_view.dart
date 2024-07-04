import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/custom_app_bar.dart';
import 'package:playground/app/modules/forum/controllers/forum_controller.dart';
import 'package:playground/app/modules/post/views/post_list_view.dart';
import 'package:playground/app/modules/post/widgets/filter_post.dart';

class ForumMobileView extends GetView<ForumController> {
  const ForumMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            snap: true,
            floating: true,
            elevation: 0,
            title: Padding(
                padding: EdgeInsets.only(top: 20), child: CustomAppBar()),
          ),
          SliverAppBar(
            pinned: true,
            flexibleSpace: FilterPost(),
          ),
          PostListView(padding: EdgeInsets.symmetric(horizontal: 10)),
        ],
      ),
    );
  }
}
