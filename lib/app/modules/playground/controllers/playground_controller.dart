import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/models/player.model.dart';
import 'package:playground/app/models/room_playground_model.dart';
import 'package:playground/app/services/user_service_information.dart';

class PlaygroundController extends GetxController {
  RxList<PlayerModel> players = <PlayerModel>[].obs;
  final userService = Get.find<UserService>();
  Rx<PlayerModel> me = PlayerModel(
    uid: '1',
    position: const Offset(0, 0),
  ).obs;
  String? currentRoomId;
  Timer? _movementTimer;
  Offset _movementOffset = Offset.zero;

  Rx<RoomPlayGroundModel> currentRoom = RoomPlayGroundModel().obs;

  void createRoom(String name, String description) async {
    DocumentReference roomRef =
        await FirebaseFirestore.instance.collection('rooms').add({
      'name': name,
      'description': description,
      'playerIds': [],
      'messages': [],
    });

    currentRoom.value = RoomPlayGroundModel(
      id: roomRef.id,
      name: name,
      description: description,
    );
  }

  void joinRoom(String roomId) async {
    DocumentSnapshot roomSnapshot =
        await FirebaseFirestore.instance.collection('rooms').doc(roomId).get();

    if (roomSnapshot.exists) {
      currentRoom.value = RoomPlayGroundModel.fromMap(
          roomSnapshot.data() as Map<String, dynamic>);
      await FirebaseFirestore.instance.collection('rooms').doc(roomId).update({
        'playerIds': FieldValue.arrayUnion([me.value.uid]),
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    me.value.uid = userService.uid;

    // Listen to Firebase for other players' updates and messages
    ever(currentRoom, (RoomPlayGroundModel room) {
      if (room.id != null) {
        _subscribeToRoom(room.id!);
      }
    });
  }

  void sendMessage(String content) async {
    MessageModel message = MessageModel(
      senderId: me.value.uid,
      content: content,
      timestamp: DateTime.now(),
    );

    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(currentRoom.value.id)
        .update({
      'messages': FieldValue.arrayUnion([message.toMap()]),
    });
  }

  void startMovement(Offset direction) {
    _movementOffset = direction;
    _movementTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      updatePosition(Offset(
        me.value.position!.dx + _movementOffset.dx,
        me.value.position!.dy + _movementOffset.dy,
      ));
    });
  }

  void stopMovement() {
    _movementTimer?.cancel();
  }

  void updatePosition(Offset newPosition) {
    me.update((player) {
      player?.position = newPosition;
    });

    FirebaseFirestore.instance
        .collection('rooms')
        .doc(currentRoom.value.id)
        .update({
      'players': FieldValue.arrayUnion([me.value.toMap()]),
    });
  }

  void _subscribeToRoom(String roomId) {
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        currentRoom.value = RoomPlayGroundModel.fromMap(
            snapshot.data() as Map<String, dynamic>);
      }
    });
  }
}
