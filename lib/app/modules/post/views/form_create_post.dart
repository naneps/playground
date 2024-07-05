import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/ui/buttons/x_button.dart';
import 'package:playground/app/common/ui/inputs/x_input.dart';
import 'package:playground/app/modules/post/controllers/create_post_controller.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

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
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ToolBar(
                        controller: controller.qController,
                        activeIconColor: Theme.of(context).primaryColor,
                        toolBarConfig: const [
                          // all content excep image
                          ToolBarStyle.bold,
                          ToolBarStyle.italic,
                          ToolBarStyle.underline,
                          ToolBarStyle.link,
                          ToolBarStyle.align,
                          ToolBarStyle.background,
                          ToolBarStyle.listBullet,
                          ToolBarStyle.listOrdered,
                          ToolBarStyle.listOrdered,
                          ToolBarStyle.codeBlock,
                          ToolBarStyle.color,
                          ToolBarStyle.clean,
                        ],
                      ),
                      const SizedBox(height: 10),
                      QuillHtmlEditor(
                        controller: controller.qController,
                        minHeight: 300,
                        hintText: "What's on your mind?",
                        loadingBuilder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        onTextChanged: (val) {
                          controller.post.value.content = val;
                        },
                      ),
                    ],
                  ),
                )
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
