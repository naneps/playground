import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/ui/inputs/x_input.dart';
import 'package:playground/app/modules/playground/controllers/rooms_controller.dart';
import 'package:playground/app/modules/playground/views/form_create_room.dart';
import 'package:playground/app/modules/playground/widgets/room_widget.dart';

class RoomsView extends GetView<RoomsController> {
  const RoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // search filter
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: XInput(
                  hintText: 'Search rooms',
                  suffixIcon: Icon(MdiIcons.magnify),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(fixedSize: const Size(140, 40)),
                onPressed: () {
                  Get.dialog(FormCreateRoom(
                    onCreate: (val) {
                      controller.currentRoom.update((room) {
                        room!.name = val.name!;
                        room.description = val.description!;
                      });
                      controller.createRoom();
                    },
                  ));
                },
                icon: Icon(MdiIcons.plus),
                label: Text(
                  'Create Room',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(
            () {
              return controller.rooms.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(MdiIcons.emoticonSadOutline, size: 100),
                        const Text('No rooms found'),
                      ],
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 2;
                        if (constraints.maxWidth < 600) {
                          crossAxisCount = 1;
                        } else if (constraints.maxWidth < 900) {
                          crossAxisCount = 2;
                        } else if (constraints.maxWidth < 1200) {
                          crossAxisCount = 3;
                        } else {
                          crossAxisCount = 4;
                        }
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: controller.rooms.length,
                          itemBuilder: (context, index) {
                            final room = controller.rooms[index];
                            return RoomWidget(
                              room: room,
                            );
                          },
                        );
                      },
                    );
            },
          ),
        )
      ],
    );
  }
}
