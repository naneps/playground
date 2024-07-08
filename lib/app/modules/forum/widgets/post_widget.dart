import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/ui/avatar_widget.dart';
import 'package:playground/app/models/post_model.dart';
import 'package:playground/app/modules/post/views/post_detail_view.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;

  final bool isLiked;
  final VoidCallback? onLike;
  const PostWidget({
    super.key,
    required this.post,
    required this.onLike,
    this.isLiked = false,
  });
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'post_detail${post.id}',
      child: Material(
        child: InkWell(
          hoverColor: Colors.grey.shade100,
          highlightColor: Colors.grey.shade100,
          onTap: () {
            Get.to(
              () => const PostDetailView(),
              arguments: post.id,
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 0.5,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1b141414),
                  blurRadius: 87.74,
                  spreadRadius: 0,
                  offset: Offset(6.23, 9.73),
                  blurStyle: BlurStyle.inner,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              post.title ?? "NOTHING TO SHOW",
                              style: Theme.of(context).textTheme.headlineSmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              MdiIcons.dotsVertical,
                            ),
                          ),
                        ],
                      ),
                      if (post.hashtags!.isNotEmpty) ...[
                        SizedBox(
                          height: 50,
                          child: Wrap(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            spacing: 5,
                            runSpacing: 2,
                            children: post.hashtags!.map((hashtag) {
                                  return Chip(
                                    label: Text(
                                      '#$hashtag',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  );
                                }).toList() ??
                                [],
                          ),
                        ),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: AvatarWidget(
                                imageUrl: post.author!.avatar!,
                                gender: post.author!.gender!,
                              ),
                              visualDensity: VisualDensity.comfortable,
                              title: Text(
                                post.author!.name ?? '',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              dense: true,
                              subtitle: Text(
                                post.dateFromNow,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                LikeButton(
                                  size: 20,
                                  circleColor: const CircleColor(
                                      start: Colors.red, end: Colors.red),
                                  bubblesColor: const BubblesColor(
                                    dotPrimaryColor: Colors.red,
                                    dotSecondaryColor: Colors.red,
                                  ),
                                  isLiked: isLiked,
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      isLiked
                                          ? MdiIcons.heart
                                          : MdiIcons.heartOutline,
                                      color: isLiked ? Colors.red : Colors.grey,
                                      size: 20,
                                    );
                                  },
                                  likeCount: post.likes,
                                  countBuilder:
                                      (int? count, bool isLiked, String text) {
                                    var color =
                                        isLiked ? Colors.red : Colors.grey;
                                    Widget result;
                                    if (count == 0) {
                                      result = Text(
                                        'love',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: color),
                                      );
                                    } else {
                                      result = Text(
                                        text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: color),
                                      );
                                    }
                                    return result;
                                  },
                                  onTap: (isLiked) async {
                                    onLike?.call();
                                    return !isLiked;
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      MdiIcons.commentOutline,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${post.comments}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      MdiIcons.eyeOutline,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${post.views}',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
