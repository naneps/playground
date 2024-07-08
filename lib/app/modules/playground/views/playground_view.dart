import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/custom_app_bar.dart';
import 'package:playground/app/modules/playground/views/rooms_view.dart';

import '../controllers/playground_controller.dart';

class PlaygroundView extends GetView<PlaygroundController> {
  const PlaygroundView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            CustomAppBar(),
            SizedBox(height: 10),
            Expanded(child: RoomsView()),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayground() {
    return Stack(
      children: [
        for (var player in controller.players)
          Positioned(
            top: player.position!.dy,
            left: player.position!.dx,
            width: 50,
            height: 50,
            child: Column(
              children: [
                if (player.typing!) Text('${player.userId} is typing...'),
                if (player.message!.isNotEmpty) Text(player.message!),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.green,
                  child: Center(child: Text(player.userId!)),
                ),
              ],
            ),
          ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    // controller: controller.messageController,
                    onChanged: (text) {
                      //   controller.updateTyping(text.isNotEmpty);
                    },
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // controller.sendMessage(controller.messageController.text);
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 20,
          child: Row(
            children: [
              GestureDetector(
                onLongPress: () {
                  controller.startMovement(const Offset(0, -10));
                },
                onLongPressUp: () {
                  controller.stopMovement();
                },
                child: IconButton(
                  icon: const Icon(Icons.arrow_upward),
                  onPressed: () {
                    controller.updatePosition(Offset(
                      controller.me.value.position!.dx,
                      controller.me.value.position!.dy - 10,
                    ));
                  },
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  controller.startMovement(const Offset(0, 10));
                },
                onLongPressUp: () {
                  controller.stopMovement();
                },
                child: IconButton(
                  icon: const Icon(Icons.arrow_downward),
                  onPressed: () {
                    controller.updatePosition(Offset(
                      controller.me.value.position!.dx,
                      controller.me.value.position!.dy + 10,
                    ));
                  },
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  controller.startMovement(const Offset(-10, 0));
                },
                onLongPressUp: () {
                  controller.stopMovement();
                },
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    controller.updatePosition(Offset(
                      controller.me.value.position!.dx - 10,
                      controller.me.value.position!.dy,
                    ));
                  },
                ),
              ),
              GestureDetector(
                onLongPress: () {
                  controller.startMovement(const Offset(10, 0));
                },
                onLongPressUp: () {
                  controller.stopMovement();
                },
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    controller.updatePosition(Offset(
                      controller.me.value.position!.dx + 10,
                      controller.me.value.position!.dy,
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoomSelection() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Create Room',
                content: const Column(
                  children: [
                    TextField(
                      //   controller: controller.roomNameController,
                      decoration: InputDecoration(hintText: 'Room Name'),
                    ),
                    TextField(
                      //   controller: controller.roomDescriptionController,
                      decoration: InputDecoration(hintText: 'Room Description'),
                    ),
                  ],
                ),
                onConfirm: () {
                  controller.createRoom('', '');
                  Get.back();
                },
              );
            },
            child: const Text('Create Room'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Join Room',
                content: const TextField(
                  decoration: InputDecoration(hintText: 'Room ID'),
                ),
                onConfirm: () {
                  controller.joinRoom('');
                  Get.back();
                },
              );
            },
            child: const Text('Join Room'),
          ),
        ],
      ),
    );
  }
}
