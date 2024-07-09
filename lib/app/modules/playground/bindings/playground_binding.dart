import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:playground/app/modules/playground/controllers/room_detail_controller.dart';
import 'package:playground/app/modules/playground/controllers/rooms_controller.dart';
import 'package:playground/app/repositories/room_repository.dart';

import '../controllers/playground_controller.dart';

class PlaygroundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomDetailController>(
      () => RoomDetailController(),
    );
    Get.lazyPut<RoomsController>(
      () => RoomsController(),
    );
    Get.lazyPut<PlaygroundController>(
      () => PlaygroundController(),
    );
    Get.lazyPut(() => RoomRepository(FirebaseFirestore.instance));
  }
}
