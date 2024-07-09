import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/playground/controllers/room_detail_controller.dart';
import 'package:playground/app/modules/playground/views/ground_widget.dart';

class RoomDetailView extends GetView<RoomDetailController> {
  const RoomDetailView({super.key});

  @override
  get controller => Get.put(RoomDetailController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Hero(
        tag: controller.currentRoom.value.id!,
        child: Scaffold(
          appBar: AppBar(
            title: Text(controller.currentRoom.value.name!),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(child: GameWidget(game: GroundWidget())),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom:
                        MediaQuery.of(context).viewInsets.bottom > 0 ? 0 : 10,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.send),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
