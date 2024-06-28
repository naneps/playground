import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/theme.dart';
import 'package:playground/app/models/post_model.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      padding: const EdgeInsets.all(10),
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
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 0.5,
              ),
              image: DecorationImage(
                image: NetworkImage(post.imageUrl ?? ''),
                fit: BoxFit.cover,
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
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  post.content ?? '',
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 30,
                  child: Wrap(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    spacing: 5,
                    runSpacing: 2,
                    children: post.hashtags?.map((hashtag) {
                          return Chip(
                            label: Text(
                              '#$hashtag',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          );
                        }).toList() ??
                        [],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: ThemeApp().primaryColor,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                NetworkImage(post.author?.avatar ?? ''),
                          ),
                        ),
                        visualDensity: VisualDensity.comfortable,
                        title: Text(
                          post.author?.name ?? '',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        dense: true,
                        subtitle: Text(
                          '${post.createdAt?.difference(DateTime.now()).inHours} hours ago',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${post.views} Views',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${post.comments} Comments',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${post.likes} Likes',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(MdiIcons.heartOutline),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
