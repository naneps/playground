import 'package:get/get.dart';
import 'package:playground/app/models/room_playground_model.dart';
import 'package:playground/app/modules/auth/views/auth_view.dart';
import 'package:playground/app/modules/playground/views/room_detail_view.dart';
import 'package:playground/app/repositories/room_repository.dart';
import 'package:playground/app/services/user_service_information.dart';

class RoomsController extends GetxController {
  RxList<RoomPlayGroundModel> rooms = <RoomPlayGroundModel>[].obs;
  Rx<RoomPlayGroundModel> currentRoom = RoomPlayGroundModel().obs;
  final userService = Get.find<UserService>();
  final RoomRepository _roomRepository = Get.find<RoomRepository>();
  Future<Stream<bool>> alReadyJoined(String roomId) async {
    return await _roomRepository.alReadyJoin(roomId, userService.uid);
  }

  void createRoom() async {
    print("Creating room");
    if (userService.user.value.uid == null) {
      return Get.dialog(const AuthView());
    }
    final room = RoomPlayGroundModel();
    await _roomRepository.add(room.copyWith(authorId: userService.uid));
  }

  void joinRoom(String roomId) async {
    await _roomRepository.joinRoom(roomId, userService.uid).then((value) {
      if (value) {
        Get.snackbar('Success', 'You have joined the room');
        Get.to(() => const RoomDetailView(), arguments: roomId);
      } else {
        Get.snackbar('Error', 'You have already joined the room');
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    streamRooms();
  }

  void streamRooms() {
    _roomRepository.streamAll().listen((newRooms) {
      rooms.assignAll(newRooms);
    });
  }
}
