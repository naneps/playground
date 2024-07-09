import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/ui/avatar_widget.dart';
import 'package:playground/app/common/ui/buttons/x_button.dart';
import 'package:playground/app/models/room_playground_model.dart';
import 'package:playground/app/modules/playground/controllers/rooms_controller.dart';
import 'package:playground/app/modules/playground/views/room_detail_view.dart';

class RoomWidget extends GetView<RoomWidgetController> {
  final RoomPlayGroundModel room;

  const RoomWidget({
    super.key,
    required this.room,
  });
  @override
  get controller =>
      Get.put(RoomWidgetController(room), permanent: true, tag: room.id);
  @override // TODO: implement tag
  String? get tag => room.id!;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          Get.to(() => const RoomDetailView(), arguments: room.id!);
        },
        child: Hero(
          tag: room.id!,
          child: Material(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade100),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.accountGroupOutline,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          room.name ?? 'room',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            //   const PopupMenuItem(
                            //     value: 'edit',
                            //     child: Text('Edit'),
                            //   ),
                            //   const PopupMenuItem(
                            //     value: 'delete',
                            //     child: Text('Delete'),
                            //   ),
                          ],
                          padding: EdgeInsets.zero,
                          child: Icon(MdiIcons.dotsVertical),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  //    list of users
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const AvatarWidget(
                                  imageUrl: '',
                                  radius: 15,
                                ),
                                title: Text(
                                  'User ${index + 1}',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                horizontalTitleGap: 10,
                                subtitle: Text(
                                  "Owner",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                visualDensity: VisualDensity.compact,
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                              );
                            },
                          ),
                        ),
                        if (controller.isJoined.isFalse) ...[
                          const SizedBox(width: 10),
                          //   join button with text vertical
                          XButton(
                            onPressed: () {
                              controller.joinRoom();
                            },
                            backgroundColor: Colors.transparent,
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 0.5,
                            ),
                            fixedSize: const Size(40, double.infinity),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  MdiIcons.accountPlus,
                                  size: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(height: 5),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Text('Join',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                          )),
                                ),
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class RoomWidgetController extends GetxController {
  final roomController = Get.find<RoomsController>();
  final RoomPlayGroundModel room;
  RxBool isJoined = false.obs;

  RoomWidgetController(this.room);
  void alReadyJoined() async {
    await roomController.alReadyJoined(room.id!).then((value) => value.listen(
          (event) {
            isJoined.value = event;
          },
        ));
  }

  void joinRoom() {
    roomController.joinRoom(room.id!);
    isJoined.value = true;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    alReadyJoined();
  }
}
