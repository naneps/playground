import 'dart:ui';

import 'package:get/get.dart';
import 'package:playground/app/models/player.model.dart';
import 'package:playground/app/models/room_playground_model.dart';
import 'package:playground/app/repositories/room_repository.dart';
import 'package:playground/app/services/user_service_information.dart';

class RoomDetailController extends GetxController {
  final roomRepository = Get.find<RoomRepository>();
  final userService = Get.find<UserService>();
  Rx<RoomPlayGroundModel> currentRoom =
      Rx<RoomPlayGroundModel>(RoomPlayGroundModel());
  Rx<PlayerModel> me = PlayerModel(
    uid: '',
    position: const Offset(0, 0),
  ).obs;
  RxList<PlayerModel> players = <PlayerModel>[].obs;
  String get roomId => Get.arguments;

  @override
  void onClose() {
    super.onClose();
    playerLeave();
  }

  @override
  onInit() {
    super.onInit();
    streamRoom();
    me.value = me.value.copyWith(userId: userService.uid);
  }

  @override
  void onReady() {
    super.onReady();
    playerJoin();
    streamPlayers();
  }

  void playerJoin() async {
    await roomRepository.playerJoin(
      player: me.value.copyWith(userId: userService.uid),
      roomId: roomId,
    );
  }

  void playerLeave() async {
    if (currentRoom.value.id != null) {
      await roomRepository.playerLeave(
        player: me.value.copyWith(userId: userService.uid),
        roomId: currentRoom.value.id!,
      );
    }
  }

  void streamPlayers() {
    roomRepository.streamPlayers(roomId).listen((event) {
      players.assignAll(event);
    });
  }

  void streamRoom() {
    roomRepository.streamOne(roomId).listen((event) {
      currentRoom(event);
    });
  }
}
