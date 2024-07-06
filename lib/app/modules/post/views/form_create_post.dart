import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/ui/buttons/x_button.dart';
import 'package:playground/app/common/ui/inputs/markdown_input.dart';
import 'package:playground/app/common/ui/inputs/x_input.dart';
import 'package:playground/app/modules/post/controllers/create_post_controller.dart';

class FormCreatePost extends GetView<CreatePostController> {
  const FormCreatePost({super.key});
  @override
  get controller => Get.put(CreatePostController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Form(
            child: Column(
              children: [
                XInput(
                  hintText: "What's on your mind?",
                  label: "Title",
                  prefixIcon: Icon(MdiIcons.text),
                  hasCounter: true,
                  maxLength: 100,
                  onChanged: (val) {
                    controller.post.value.title = val;
                  },
                ),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.all(10),
                    constraints:
                        BoxConstraints(minHeight: 200, maxHeight: Get.height),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const MarkdownInput())
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: XButton(
                  text: "Save Draft",
                  onPressed: () {},
                  backgroundColor: Colors.grey.shade100,
                  textStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: XButton(
                  text: "Publish",
                  onPressed: () {
                    controller.createPost();
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
