import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/overlays/loading_dialog.dart';
import 'package:playground/app/models/player.model.dart';
import 'package:playground/app/models/room_playground_model.dart';
import 'package:playground/app/models/user.model.dart';
import 'package:playground/app/repositories/base_repository.dart';

class RoomRepository extends BaseRepository<RoomPlayGroundModel> {
  RoomRepository(super.firestore);

  @override
  CollectionReference get collection => firestore.collection('rooms');

  @override
  Future<void> add(RoomPlayGroundModel item) async {
    LoadingDialog.show(Get.context!);
    await collection.add(toJson(item)).then((value) {
      value.update({'id': value.id});
    });
    LoadingDialog.hide(Get.context!);
  }

  Future<Stream<bool>> alReadyJoin(String roomId, String userId) async {
    return collection.doc(roomId).snapshots().map((event) {
      final data = event.data() as Map<String, dynamic>;
      final userIds = data['userIds'] as List;
      return userIds.contains(userId);
    });
  }

  @override
  Future<void> delete(String id) {
    return collection.doc(id).delete();
  }

  @override
  RoomPlayGroundModel fromJson(Map<String, dynamic> json) {
    return RoomPlayGroundModel.fromMap(json);
  }

  @override
  Future<List<RoomPlayGroundModel>> getAll() {
    return collection.get().then((value) {
      return value.docs
          .map((e) => fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<List<RoomPlayGroundModel>> getFiltered(
      {required Map<String, dynamic> filters,
      DocumentSnapshot<Object?>? startAfter,
      int limit = 10}) {
    final query = collection;
    filters.forEach((field, value) {
      query.where(field, isEqualTo: value);
    });

    if (startAfter != null) {
      query.startAfterDocument(startAfter);
    }

    query.orderBy('createdAt', descending: true).limit(limit);
    return query.get().then((value) {
      return value.docs
          .map((e) => fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Stream<UserModel> getUser(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map((event) {
      return UserModel.fromJson(event.data() as Map<String, dynamic>);
    });
  }

  Future<bool> joinRoom(String roomId, String userId) async {
    final room = await collection.doc(roomId).get();
    final data = room.data() as Map<String, dynamic>;
    final userIds = data['userIds'] as List;
    userIds.add(userId);
    await collection.doc(roomId).update({'userIds': userIds});
    return true;
  }

  Future<void> playerJoin(
      {required String roomId, required PlayerModel player}) async {
    final playerCollection = collection.doc(roomId).collection('players');
    await playerCollection.doc(player.userId).set(player.toMap());
  }

  Future<void> playerLeave(
      {required PlayerModel player, required String roomId}) async {
    final playerCollection = collection.doc(roomId).collection('players');
    await playerCollection.doc(player.userId).delete();
  }

  @override
  Stream<List<RoomPlayGroundModel>> streamAll() {
    return collection.snapshots().map((event) {
      return event.docs
          .map((e) => fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Stream<RoomPlayGroundModel> streamOne(String id) {
    return collection.doc(id).snapshots().map((event) {
      return fromJson(event.data() as Map<String, dynamic>);
    });
  }

  Stream<List<PlayerModel>> streamPlayers(String roomId) {
    return collection
        .doc(roomId)
        .collection('players')
        .snapshots()
        .map((event) {
      return event.docs.map((e) => PlayerModel.fromDocument(e)).toList();
    });
  }

  @override
  Map<String, dynamic> toJson(RoomPlayGroundModel item) {
    return item.toMap();
  }

  @override
  Future<void> update(RoomPlayGroundModel item) {
    throw UnimplementedError();
  }

  Future<void> updatePlayerPosition(
      {required PlayerModel player, required String roomId}) async {
    final playerCollection = collection.doc(roomId).collection('players');
    await playerCollection.doc(player.uid).update(player.toMap());
  }
}
