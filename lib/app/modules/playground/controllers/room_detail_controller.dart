import 'package:get/get.dart';
import 'package:playground/app/models/room_playground_model.dart';
import 'package:playground/app/repositories/room_repository.dart';

class RoomDetailController extends GetxController {
  //TODO: Implement RoomDetailController
  final roomRepository = Get.find<RoomRepository>();
  Rx<RoomPlayGroundModel> currentRoom =
      Rx<RoomPlayGroundModel>(RoomPlayGroundModel());
  String get roomId => Get.arguments;

  @override
  void onClose() {
    currentRoom.close();
    super.onClose();
  }

  @override
  onInit() {
    streamRoom();
    super.onInit();
  }

  void streamRoom() {
    roomRepository.streamOne(roomId).listen((event) {
      currentRoom(event);
    });
  }
}
